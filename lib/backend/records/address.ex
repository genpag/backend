defmodule Backend.Records.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias Backend.Validations.CommonsValidations

  @derive {Jason.Encoder, only: [:city, :complement, :neighborhood, :number, :postal_code, :state, :street]}
  schema "address" do
    field :city, :string
    field :complement, :string
    field :neighborhood, :string
    field :number, :integer
    field :postal_code, :string
    field :state, :string
    field :street, :string

    belongs_to :account, Backend.Records.Account

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:state, :city, :neighborhood, :postal_code, :complement, :number])
    |> validate_length(:state, min: 2, max: 2)
    |> validate_length(:postal_code, min: 8)
    |> CommonsValidations.validate_only_number(:postal_code, &get_field/2)
    |> validate_postal_code_search(:create)
  end

  def update_changeset(address, attrs) do
    address
    |> cast(attrs, [:street, :number, :complement, :neighborhood, :city, :state, :postal_code])
    |> validate_length(:state, min: 2, max: 2)
    |> validate_length(:postal_code, min: 8)
    |> CommonsValidations.validate_only_number(:postal_code, &get_change/2)
    |> validate_postal_code_search(:update)
  end

  def delete_changeset(address, attrs) do
    address
    |> cast(attrs, [:street, :number, :complement, :neighborhood, :city, :state, :postal_code])
  end

  defp validate_postal_code_search(changeset, operation) do
    postal_code = get_postal_code_by_operation(operation, changeset)

    case postal_code do
      nil ->
        if operation == :create, do: add_error(changeset, :postal_code, "it's required"), else: changeset
      _ ->
        case Tesla.get("https://viacep.com.br/ws/#{postal_code}/json/") do
          {:ok, tesla_env} ->
            unless tesla_env.status == 400 do
              body = Jason.decode!(tesla_env.body)
              case body do
                %{"erro" => _erro} ->
                  changeset =
                    add_error(changeset, :postal_code, "it's invalid or unkown")
                    |> error_when_field_nil(operation, :state)
                    |> error_when_field_nil(operation, :city)
                    |> error_when_field_nil(operation, :neighborhood)
                    |> error_when_field_nil(operation, :street)
                  changeset
                _ ->
                  changeset =
                    change_when_field_nil(changeset, operation, :state, body["uf"])
                    |> change_when_field_nil(operation, :city, body["localidade"])
                    |> change_when_field_nil(operation, :neighborhood, body["bairro"])
                    |> change_when_field_nil(operation, :street, body["logradouro"])
                    |> change_when_field_nil(operation, :complement, body["complemento"])
                  changeset
              end
            else
              changeset
            end

          {:error, _error} ->
            add_error(changeset, :postal_code, "message: an error ocurred")
        end
    end
  end

  defp change_when_field_nil(changeset, operation, field, new_value) do
    if is_nil(get_field_by_operation_function(operation, changeset, field)), do: put_change(changeset, field, new_value), else: changeset
  end

  defp error_when_field_nil(changeset, operation, field) do
    if is_nil(get_field_by_operation_function(operation, changeset, field)), do: add_error(changeset, field, "it's required"), else: changeset
  end

  defp get_postal_code_by_operation(operation, changeset) do
    case operation do
      :update ->
        get_change(changeset, :postal_code)
      _ ->
        get_field(changeset, :postal_code)
    end
  end

  defp get_field_by_operation_function(operation, changeset, field) do
    case operation do
      :update ->
        get_change(changeset, field)
      _ ->
        get_field(changeset, field)
    end
  end
end
