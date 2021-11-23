defmodule Test do
    alias Backend.ConsultaCep.ConsultaCep
    alias Backend.Helpers.Helpers
    alias Backend.{Account, Address, Repo}
    alias Backend.Address
    alias Backend.Accounts.Create

    @address_fields [
      {"street", "logradouro"},
      {"number", "numero"},
      {"complement", "complemento"},
      {"neighborhood", "bairro"},
      {"city", "localidade"},
      {"state", "uf"},
      {"postal_code", "cep"}
    ]

    #
#     %{
#   "bairro" => "São Marcos I",
#   "cep" => "29176-195",
#   "complemento" => "",
#   "ddd" => "27",
#   "gia" => "",
#   "ibge" => "3205002",
#   "localidade" => "Serra",
#   "logradouro" => "Rua Samambaia",
#   "siafi" => "5699",
#   "uf" => "ES"
# }

    def test do
    map = %{
  "bairro" => "São Marcos I",
  "cep" => "29176-195",
  "complemento" => "",
  "ddd" => "27",
  "gia" => "",
  "ibge" => "3205002",
  "localidade" => "Serra",
  "logradouro" => "Rua Samambaia",
  "siafi" => "5699",
  "uf" => "ES"
}

  Helpers.merge_address_map(map)

  end
end


# IO.inspect(params, label: "PARAMS ==================")
# with {:ok, %Account{} = account} <- Backend.create_account(params),
# %Backend.Account{id: account_id} = account,
# address = Map.put(params["address"], "account_id", account_id),
# {:ok, %Address{} = account} <- Backend.create_address(address)
# do
#     IO.inspect(account, label: "ACCOUNT")
# #    conn
# #    |> put_status(:created)
# #    |> render("create.json", account: account)

# # remove after test
# conn
#     |> put_status(:no_content)
#     |> text("")
