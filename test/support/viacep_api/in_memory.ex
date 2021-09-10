defmodule Backend.ViacepAPI.InMemory do
  @moduledoc """
  The ViacepAPI mocks.
  """
  alias Backend.Account.Address
  alias Backend.ViacepAPI

  @behaviour ViacepAPI

  @doc false
  def fetch_address("valid_postal_code") do
    {:ok,
     %Address{
       city: "Cidade",
       complement: "Complemento do endereço",
       neighborhood: "Bairro",
       number: nil,
       postal_code: "81330580",
       state: "UF",
       street: "Rua dos bobos"
     }}
  end
end
