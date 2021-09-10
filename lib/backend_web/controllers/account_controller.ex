defmodule BackendWeb.AccountController do
  use BackendWeb, :controller

  alias Backend.Accounts

  action_fallback BackendWeb.FallbackController

  def create(conn, params) do
    with {:ok, address} <- Accounts.load_address(params["address"]),
         {:ok, user} <- Accounts.create_user(params, address) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "address" => address} = params) do
    with {:ok, address} <- Accounts.load_address(address),
         {:ok, user} <- Accounts.get_user(id),
         {:ok, user} <- Accounts.update_user(user, params, address) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user(id),
         {:ok, _struct} <- Accounts.delete_user(user) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def index(conn, params) do
    with {:ok, users} <- Accounts.get_users(params) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: users)
    end
  end
end
