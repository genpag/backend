defmodule Backend.Accounts.Delete do
    alias Backend.{Account, Error, Repo}

    def call(id) do
      case Repo.get(Account, id) do
          nil -> {:error, Error.build_account_not_found_error()}
          account -> Repo.delete(account)
      end
    end
end
