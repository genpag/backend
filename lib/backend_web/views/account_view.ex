defmodule BackendWeb.AccountView do
  use BackendWeb, :view

  alias Backend.Account.User

  def render("show.json", %{user: user}) when is_list(user) do
    Enum.map(user, &render("show.json", %{user: &1}))
  end

  def render("show.json", %{user: %User{address: addr} = user}) do
    %{
      cpf: user.cpf,
      id: user.id,
      name: user.name,
      address: render("show.json", %{address: addr})
    }
  end

  def render("show.json", %{address: address}) when is_list(address) do
    Enum.map(address, &render("show.json", %{address: &1}))
  end

  def render("show.json", %{address: address}) do
    %{
      city: address.city,
      complement: address.complement,
      neighborhood: address.neighborhood,
      number: address.number,
      postal_code: address.postal_code,
      state: address.state,
      street: address.street
    }
  end
end
