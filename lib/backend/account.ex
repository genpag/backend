defmodule Backend.Account do
    use Ecto.Schema
    import Ecto.Changeset
    alias Backend.Address

    @required_params [:cpf, :name]
    @derive {Jason.Encoder, only: [:id, :cpf, :name]}

    schema "accounts" do
      field :cpf, :string
      field :name, :string
      has_one :address, Address
      timestamps()
    end

    def changeset(struct \\ %__MODULE__{}, params) do
        struct
        |> cast(params, @required_params)
        |> validate_required(@required_params)
        |> validate_length(:cpf, is: 11)
        |> validate_length(:name, min: 3)
        |> unique_constraint([:cpf])
    end
end
