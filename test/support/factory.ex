defmodule Backend.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Backend.Repo

  alias Backend.Account.{Address, User}

  def user_factory do
    %User{
      name: "Test User",
      cpf: "CPF Code",
      address: address_factory()
    }
  end

  def address_factory do
    %Address{
      street: "Rua Arthur Martins Franco",
      complement: "de 2541/2542 ao fim",
      neighborhood: "Fazendinha",
      city: "Curitiba",
      state: "PR",
      number: "1234",
      postal_code: "81330580"
    }
  end
end
