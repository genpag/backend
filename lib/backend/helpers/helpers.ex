defmodule Backend.Helpers.Helpers do
  @address_fields [
    {"street", "logradouro"},
    {"number", "numero"},
    {"complement", "complemento"},
    {"neighborhood", "bairro"},
    {"city", "localidade"},
    {"state", "uf"},
    {"postal_code", "cep"}
  ]

  def merge_address_map(values) do
    Enum.reduce(@address_fields, %{}, fn {key, new_key}, address ->
      Map.put(address, key, Map.get(values, new_key))
    end)
  end

  def map_keys_to_atoms(map) do
    map
    |> Map.keys()
    |> Enum.zip(Map.values(map))
    |> Enum.reduce(%{}, fn {k, v}, map ->
      Map.put(map, String.to_atom(k), v)
    end) |> IO.inspect(label: "HELPER =========")
  end

  def verify_cep_length(cep) when is_binary(cep) do
    {:ok, String.length(cep)}
  end
  def verify_cep_length(_), do: {:error, "Invalid CEP"}
end
