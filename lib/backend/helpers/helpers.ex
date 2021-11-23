defmodule Backend.Helpers.Helpers do
  @address_fields [
    {:street, "logradouro"},
    {:number, "numero"},
    {:complement, "complemento"},
    {:neighborhood, "bairro"},
    {:city, "localidade"},
    {:state, "uf"},
    {:postal_code, "cep"}
  ]

  def merge_address_map(values) do
    Enum.reduce(@address_fields, %{}, fn {key, new_key}, address ->
      Map.put(address, key, Map.get(values, new_key))
    end)
  end

  def verify_cep_length(cep) when is_binary(cep) do
    {:ok, String.length(cep)}
  end
  def verify_cep_length(_), do: {:error, "Invalid CEP"}
end
