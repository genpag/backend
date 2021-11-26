defmodule BackendWeb.AccountController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Helpers.ConnHelper
  alias Backend.Helpers.ResponseHelper

  def show(conn, params) do
    id = params["id"]

    case Accounts.get_account(id) do
      {:ok, account} ->
        conn
        |> ConnHelper.ok()
        |> render("show.json", %{account: account})
      {:error, :account_not_found} ->
        conn
        |> ConnHelper.not_found()
    end
  end

  def create(conn, params) do
    case Accounts.create(params) do
      {:ok, account} ->
        conn
        |> ConnHelper.created()
        |> render("create.json", %{id: account.id})
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> ConnHelper.unprocessable_entity()
        |> json(ResponseHelper.response_body(changeset))
      _ ->
        conn
        |> ConnHelper.internal_server_error()
    end
  end
end
