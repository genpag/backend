defmodule Backend.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:account) do
      add :name, :string, null: false
      add :cpf, :string, null: false

      add :address_id, references(:address)

      timestamps()
    end

    create index(:account, [:address_id])
    create unique_index(:account, [:cpf])
  end
end
