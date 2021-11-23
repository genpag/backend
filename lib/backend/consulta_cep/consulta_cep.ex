defmodule Backend.ConsultaCep.ConsultaCep do
    @endpoint System.get_env("BUSCA_CEP", "https://viacep.com.br/ws")

    def busca_cep(cep) do
        "#{@endpoint}/#{cep}/json/unicode"
        |> HTTPoison.get()
        |> busca_cep_handler()
    end

    defp busca_cep_handler({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
        body
        |> Jason.decode!(keys: :strings)
        |> found_body()
    end

    defp busca_cep_handler({:ok, %HTTPoison.Response{status_code: 400}}), do: {:error, "Invalid CEP"}

    defp found_body(%{"erro" => true}), do: {:error, "Invalid CEP"}
    defp found_body(body), do: body
end
