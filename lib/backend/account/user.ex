defmodule Backend.Account.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Account.Address

  @params [:name, :cpf]

  schema "account_users" do
    field :cpf, :string
    field :name, :string

    embeds_one(:address, Address, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, params, address)

  def changeset(user, params, nil) do
    user
    |> cast(params, @params)
    |> validate_required(@params)
  end

  def changeset(user, %{"address" => %{"number" => number}} = params, address) do
    user
    |> cast(params, @params)
    |> put_address(address, number)
    |> validate_required(@params)
  end

  defp put_address(changeset, address, number) do
    address = Address.put_number(address, number)

    changeset
    |> put_embed(:address, address)
  end
end
