defmodule Backend.Repo.Migrations.CreateAccountUsers do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :name, :string
      add :cpf, :string
      add :address, :map

      timestamps()
    end
  end
end
