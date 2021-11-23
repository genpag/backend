defmodule Backend.Accounts.Get do
    alias Backend.{Account, Error, Repo}
    import Ecto.Query

    def by_id(id) do
      case Repo.get(Account, id) do
          nil -> {:error, Error.build_account_not_found_error()}
          account -> {:ok, account}
      end
    end

    def list(limit \\ 2, offset \\ 0) do
      Account
      |> limit(^limit)
      |> offset(^offset)
      |> Repo.all()
    end

    def list_all(), do: Repo.all(Account)
end
