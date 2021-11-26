defmodule ViaCepApiBehaviour do
  @callback get_address_by_postal_code(String.t()) :: term()
end
