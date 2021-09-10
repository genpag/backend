defmodule Backend.Account.User.BuildTest do
  @moduledoc false

  use Backend.DataCase, async: true

  alias Backend.Account.{Address, User}
  alias Ecto.Changeset

  @valid_addr_attrs %Address{
    street: "Rua Arthur Martins Franco",
    number: 1234,
    complement: "de 2541/2542 ao fim",
    neighborhood: "Fazendinha",
    city: "Curitiba",
    state: "PR",
    postal_code: "81330580"
  }

  @valid_attrs %{
    "name" => "Test User",
    "cpf" => "CPF Code",
    "address" => %{
      "number" => "1234",
      "postal_code" => "81330580"
    }
  }

  test "receives a map with attributes and returns a new user" do
    user =
      @valid_attrs
      |> User.changeset(@valid_addr_attrs)
      |> Changeset.apply_changes()

    assert user == %User{
             name: "Test User",
             cpf: "CPF Code",
             address: %Address{
               street: "Rua Arthur Martins Franco",
               complement: "de 2541/2542 ao fim",
               neighborhood: "Fazendinha",
               city: "Curitiba",
               state: "PR",
               number: "1234",
               postal_code: "81330580"
             }
           }
  end
end
