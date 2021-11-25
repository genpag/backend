defmodule BackendWeb.AccountView do
  use BackendWeb, :view

  def render("create.json", %{id: id}) do
    ResponseHelper.response_body(%{id: id})
  end
end
