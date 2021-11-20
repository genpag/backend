defmodule Backend.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:address) do
      add :state, :string, null: false
      add :city, :string, null: false
      add :neighborhood, :string, null: false
      add :postal_code, :string, null: false
      add :complement, :string
      add :street, :string, null: false
      add :number, :integer

      timestamps()
    end

  end
end
