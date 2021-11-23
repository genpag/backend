defmodule BackendWeb.AccountsController do
    use BackendWeb, :controller

    alias Backend.Account
    alias BackendWeb.FallbackController

    action_fallback FallbackController

    def create(conn, params) do
        #//TODO
        IO.inspect(params, label: "PARAMS ==================")
        with {:ok, %Account{} = account} <- Backend.create_account(params) do
           conn
           |> put_status(:created)
           |> render("create.json", account: account)
        end
    end

    def delete(conn, %{"id" => id}) do
        with {:ok, %Account{}} <- Backend.delete_account(id) do
            conn
            |> put_status(:no_content)
            |> text("")
         end
    end

    def index(%Plug.Conn{query_params: query_params} = conn, _params) do
        case query_params do
            %{"limit" => limit, "offset" => offset} ->
                list = Backend.list_accounts(limit, offset)
                conn
                |> put_status(:ok)
                |> render("account_list.json", account: list)
            %{} ->
                list = Backend.list_all_accounts()
                conn
                |> put_status(:ok)
                |> render("account_list.json", account: list)
        end
    end

    def show(conn, %{"id" => id}) do
        with {:ok, %Account{} = account} <- Backend.get_account_by_id(id) do
            conn
            |> put_status(:ok)
            |> render("account.json", account: account)
        end
    end

    def update(conn, params) do
        with {:ok, %Account{} = account} <- Backend.update_account(params) do
            conn
            |> put_status(:ok)
            |> render("account.json", account: account)
        end
    end
  end
