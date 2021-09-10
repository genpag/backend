defmodule Backend.Account.Address.BuildTest do
  @moduledoc false

  use Backend.DataCase, async: true

  alias Backend.Account.Address

  @valid_attrs %{
    "localidade" => "Curitiba",
    "complemento" => "de 2541/2542 ao fim",
    "bairro" => "Fazendinha",
    "number" => nil,
    "cep" => "81330-580",
    "uf" => "PR",
    "logradouro" => "Rua Arthur Martins Franco"
  }

  test "receives a map with attributes and returns a new address" do
    addr = Address.build(@valid_attrs)

    assert addr == %Address{
             street: "Rua Arthur Martins Franco",
             complement: "de 2541/2542 ao fim",
             neighborhood: "Fazendinha",
             city: "Curitiba",
             state: "PR",
             postal_code: "81330-580"
           }
  end
end
