defmodule Backend.Repo.Migrations.CreateAccountTable do
  use Ecto.Migration

  def change do
    create table :accounts do
      add :cpf, :string
      add :name, :string
      add :address, :string

      timestamps()
    end

    create unique_index(:accounts, [:cpf])
  end
end
