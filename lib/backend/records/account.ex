defmodule Backend.Records.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Validations.CommonsValidations

  @derive {Jason.Encoder, only: [:id, :cpf, :name, :address]}
  schema "account" do
    field :cpf, :string
    field :name, :string

    has_one :address, Backend.Records.Address

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :cpf])
    |> cast_assoc(:address, require: true, with: &Backend.Records.Address.changeset/2)
    |> CommonsValidations.validate_only_number(:cpf, &get_field/2)
    |> validate_length(:cpf, min: 11, max: 11)
    |> validate_required([:name, :cpf, :address])
    |> unique_constraint([:cpf])
  end
end
