defmodule Backend.Address do
    use Ecto.Schema
    import Ecto.Changeset

    alias Backend.Account

    @required_params [:postal_code]
    @derive  {Jason.Encoder, only: [:id, :street, :number, :complement, :neighborhood, :city, :state, :postal_code]}

    schema "address" do
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

    def changeset(struct \\ %__MODULE__{}, params) do
        struct
        |> cast(params, @required_params)
        |> validate_required(@required_params)
        |> put_assoc(:account, params)
        |> validate_length(:street, min: 3)
        |> validate_length(:neighborhood, min: 3)
        |> validate_length(:city, min: 3)
        |> validate_length(:state, is: 2)
    end
end
