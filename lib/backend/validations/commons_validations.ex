defmodule Backend.Validations.CommonsValidations do
  import Ecto.Changeset

  def validate_only_number(changeset, field, get_function_operation) do
    field_value = get_function_operation.(changeset, field)
    unless is_nil(field_value) do
      case Integer.parse(field_value) do
        {_number, string} ->
          if String.length(string) > 0, do: add_error(changeset, field, "must be only numbers"), else: changeset
        :error ->
          add_error(changeset, field, "must be only numbers")
      end
    else
      changeset
    end
  end
end
