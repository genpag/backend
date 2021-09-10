defmodule Backend.Account.Address.LoadPostalCode do
  @moduledoc """
  Defines funcions to load the postal code into an Address
  """

  alias Backend.ViacepAPI.HttpClient

  def call(address), do: HttpClient.fetch_address(address["postal_code"])
end
