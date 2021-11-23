defmodule Backend.Address.Create do
    alias Backend.{Address, Error, Repo}

    def call(params) do
        params
        |> Address.changeset()
        |> Repo.insert()
        |> handle_insert()
    end

    defp handle_insert({:ok, %Address{}} = result), do: result
    defp handle_insert({:error, result}) do
        {:error, Error.build(:bad_request, result)}
    end
end
