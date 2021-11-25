defmodule Backend.Repo.Migrations.AddAddressesTable do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :street, :string
      add :number, :string
      add :complement, :string
      add :neighborhood, :string
      add :city, :string
      add :state, :string
      add :postal_code, :string

      add :account_id, references(:accounts)

      timestamps()
    end

    create index(:addresses, :postal_code)
  end
end
