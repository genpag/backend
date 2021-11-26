defmodule Backend.Accounts.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Accounts.Account

  @cast_changeset_fields ~w(
    street
    number
    complement
    neighborhood
    city
    state
    postal_code
  )a

  @required_changeset_fields ~w(
    postal_code
    street
    neighborhood
    city
    state
  )a

  schema "addresses" do
    field :street, :string
    field :number, :string
    field :complement, :string
    field :neighborhood, :string
    field :city, :string
    field :state, :string
    field :postal_code, :string

    belongs_to :account, Account

    timestamps()
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, @cast_changeset_fields)
    |> validate_required(@required_changeset_fields)
    |> validate_length(:postal_code, is: 8)
  end

  def changeset_postal_code(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:postal_code])
    |> validate_required([:postal_code])
    |> validate_length(:postal_code, is: 8)
  end
end
