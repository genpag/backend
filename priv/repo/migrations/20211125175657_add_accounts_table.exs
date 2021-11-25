defmodule Backend.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :cpf, :string

      timestamps()
    end

    create unique_index(:accounts, :cpf)
  end
end
