defmodule BackendWeb.AccountView do
  use BackendWeb, :view

  def render("show.json", %{account: account}) do
    ResponseHelper.response_body(
      %{account: render_one(account, __MODULE__, "account.json", as: :account)}
    )
  end

  def render("create.json", %{id: id}) do
    ResponseHelper.response_body(%{id: id})
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      cpf: account.cpf,
      name: account.name,
      address: %{
        street: account.address.street,
        number: account.address.number,
        complement: account.address.complement,
        neighborhood: account.address.neighborhood,
        city: account.address.city,
        state: account.address.state,
        postal_code: account.address.postal_code,
      }
    }
  end
end
