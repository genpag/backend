defmodule Backend.Repo.Migrations.AddAccountReferenceToAddress do
  use Ecto.Migration

  def change do
    alter table(:address) do
      add :account_id, references(:account)
    end
  end
end
