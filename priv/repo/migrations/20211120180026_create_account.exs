defmodule Backend.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:account) do
      add :name, :string
      add :cpf, :string
      add :address_id, references(:address)

      timestamps()
    end

    create index(:account, [:address_id])
  end
end
