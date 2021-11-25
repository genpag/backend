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
  )a

  @required_fields_when_post_code_exist ~w(
    street
    neighborhood
    city
    state
  )

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

  def changeset(status, attrs) do
    status
    |> cast(attrs, @cast_changeset_fields)
    |> validate_required(@required_changeset_fields)
  end
end
