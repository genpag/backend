defmodule Backend.ViacepAPI.HttpClient do
  @moduledoc """
  The ViacepAPI Http Client.
  """

  alias Backend.Account.Address
  alias Backend.ViacepAPI
  alias HTTPoison.Response

  @behaviour ViacepAPI

  @viacep_api_url "https://viacep.com.br/ws/"
  @viacep_api_params "/json/unicode"

  @doc """
  Call the Viacep API and fetch the address of a given postal code
  """
  def fetch_address(postal_code) do
    uri = @viacep_api_url <> postal_code <> @viacep_api_params

    case HTTPoison.get(uri) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok,
         body
         |> Jason.decode!()
         |> Address.build()}

      {:ok, %Response{status_code: 400}} ->
        {:error, :address_not_found}

      _ ->
        {:error, :unexpected}
    end
  end
end
