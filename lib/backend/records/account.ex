defmodule Backend.Records.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Validations.CommonsValidations

  @derive {Jason.Encoder, only: [:id, :cpf, :name, :address]}
  schema "account" do
    field :cpf, :string
    field :name, :string

    has_one :address, Backend.Records.Address, on_replace: :update

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
    |> unique_constraint(:cpf)
  end

  def update_changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :cpf])
    |> cast_assoc(:address, with: &Backend.Records.Address.update_changeset/2)
    |> CommonsValidations.validate_only_number(:cpf, &get_change/2)
    |> verify_change_cpf_block
  end

  def delete_changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :cpf])
    |> cast_assoc(:address, require: true, with: &Backend.Records.Address.delete_changeset/2)
  end

  defp verify_change_cpf_block(changeset) do
    case get_change(changeset, :cpf) do
      nil ->
        changeset
      _ ->
        add_error(changeset, :cpf, "cannot be changed")
    end
  end
end
