defmodule Backend.Repo.Migrations.CreateAddress do
  use Ecto.Migration

  def change do
    create table(:address) do
      add :state, :string
      add :city, :string
      add :neighborhood, :string
      add :postal_code, :integer
      add :complement, :string
      add :number, :integer

      timestamps()
    end

  end
end
