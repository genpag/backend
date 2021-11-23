defmodule Backend.Accounts.Create do
    alias Backend.{Account, Error, Repo}

    def call(params) do
        params
        |> Account.changeset()
        |> Repo.insert()
        |> handle_insert()
    end

    defp handle_insert({:ok, %Account{}} = result), do: result
    defp handle_insert({:error, result}) do
        {:error, Error.build(:bad_request, result)}
    end
end
