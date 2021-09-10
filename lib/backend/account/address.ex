defmodule Backend.Account.Address do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @params [
    :street,
    :number,
    :complement,
    :neighborhood,
    :city,
    :state,
    :postal_code
  ]

  @required_params [:postal_code]

  @optional_params [
    :street,
    :neighborhood,
    :city,
    :state
  ]

  embedded_schema do
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :postal_code, :string
    field :state, :string
    field :street, :string
  end

  @doc false
  def changeset(address \\ %__MODULE__{}, attrs) do
    address
    |> cast(attrs, @params)
    |> validate_required(@required_params)
  end

  def validate_optional(changeset) do
    changeset
    |> validate_required(@optional_params)
  end

  def build(%{
        "logradouro" => street,
        "complemento" => complement,
        "bairro" => neighborhood,
        "localidade" => city,
        "uf" => state,
        "cep" => postal_code
      }) do
    %__MODULE__{}
    |> cast(
      %{
        street: street,
        complement: complement,
        neighborhood: neighborhood,
        city: city,
        state: state,
        postal_code: postal_code
      },
      @params
    )
    |> validate_required(@required_params)
    |> apply_changes()
  end

  def build(_), do: {:error, :address_not_found}

  def put_number(changeset, number) do
    changeset
    |> change(%{number: number})
  end
end
