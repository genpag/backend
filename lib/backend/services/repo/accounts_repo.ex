defmodule Backend.Services.Repo.AccountsRepo do
  import Ecto.Query, warn: false

  alias Backend.Accounts.Account
  alias Backend.Repo

  def get_account(id) do
    account =
      query_main()
      |> where_by_id(id)
      |> preloads(:address)
      |> Repo.one()
    if is_nil(account), do: {:not_found}, else: {:ok, account}
  end

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  defp query_main(), do: from(account in Account, as: :account)
  defp where_by_id(query, value), do: from([account: a] in query, where: a.id == ^value)
  defp preloads(query, preloads), do: from([account: a] in query, preload: ^preloads)
end
