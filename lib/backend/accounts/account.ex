defmodule Backend.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Accounts.Address

  @cast_changeset_fields ~w(
    name
    cpf
  )a

  @required_changeset_fields ~w(
    name
    cpf
  )a

  schema "accounts" do
    field :name, :string
    field :cpf, :string

    has_one :address, Address

    timestamps()
  end

  def changeset(account, attrs) do
    account
    |> cast(attrs, @cast_changeset_fields)
    |> validate_required(@required_changeset_fields)
    |> unique_constraint(:cpf)
    |> cast_assoc(:address, required: true)
  end
end
