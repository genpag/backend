defmodule Backend.Records.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "address" do
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :postal_code, :integer
    field :state, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:state, :city, :neighborhood, :postal_code, :complement, :number])
    |> validate_required([:state, :city, :neighborhood, :postal_code, :complement, :number])
  end
end
