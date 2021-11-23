defmodule Backend.Accounts.Update do
    alias Backend.{Account, Error, Repo}

    def call(%{"id" => id} = params) do
      case Repo.get(Account, id) do
          nil -> {:error, Error.build_account_not_found_error()}
          account -> do_update(account, params)
      end
    end

    defp do_update(account, params) do
        account
        |> Account.changeset(params)
        |> Repo.update()
    end
end
