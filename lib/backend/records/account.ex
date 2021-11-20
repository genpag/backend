defmodule Backend.Records.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "account" do
    field :cpf, :string
    field :name, :string
    field :address_id, :id

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :cpf])
    |> validate_required([:name, :cpf])
  end
end
