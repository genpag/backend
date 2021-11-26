defmodule Backend.Services.Apis.ViaCepApi do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br"
  plug Tesla.Middleware.JSON

  alias Plug.Conn

  @behaviour ViaCepApiBehaviour
  @status_code_success Conn.Status.code(:ok)

  def get_address_by_postal_code(postal_code) do
    "/ws/#{postal_code}/json/"
    |> get()
    |> handle_response()
  end

  def handle_response({:ok, %Tesla.Env{status: @status_code_success, body: %{"erro" => true}}}),
      do: {:error, :not_found}

  def handle_response({:ok, %Tesla.Env{status: @status_code_success, body: body}}) do
    {:ok,
      %{
        "street" => body["logradouro"],
        "complement" => body["complemento"],
        "neighborhood" => body["bairro"],
        "city" => body["localidade"],
        "state" => body["uf"]
      }}
  end

  def handle_response({:ok, %Tesla.Env{}}), do: {:error, :bad_request}
end
