defmodule Backend.Repo.Migrations.CreateAddressTable do
  use Ecto.Migration

  def change do
    create table(:address) do
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

    create unique_index(:address, [:account_id])
  end
end
