defmodule Backend.Services.Repo.AccountsRepo do
  import Ecto.Query, warn: false

  alias Backend.Accounts.Account
  alias Backend.Repo

  def create_account(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
