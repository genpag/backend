defmodule Backend.ViacepAPI do
  @moduledoc """
  The ViacepAPI behaviour
  """

  alias Backend.Account.Address

  @callback fetch_address(postal_code :: String.t()) ::
              {:ok, %Address{}} | {:error, atom()}
end
