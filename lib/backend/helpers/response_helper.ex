defmodule Backend.Helpers.ResponseHelper do

  def response_body(%Ecto.Changeset{} = changeset), do: %{error: changeset_error_to_string(changeset)}
  def response_body(data), do: %{data: data}

  defp changeset_error_to_string(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}}", to_string(value))
      end)
    end)
  end
end
