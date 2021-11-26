defmodule Backend.AccountFactory do
  use ExMachina.Ecto, repo: Backend.Repo

  alias Backend.Accounts

  def address_factory do
    %Accounts.Address{
      street: "street",
      number: "number",
      complement: "complement",
      neighborhood: "neighborhood",
      city: "city",
      state: "state",
      postal_code: "12345678",
    }
  end

  def account_factory do
    %Accounts.Account{
      cpf: "1",
      name: "name",
      address: build(:address),
    }
  end
end