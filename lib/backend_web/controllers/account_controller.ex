defmodule BackendWeb.AccountController do
  use BackendWeb, :controller
  import Ecto.Query
  alias Backend.Records.Account

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case changeset.valid? do
      true ->
        case Backend.Repo.insert(changeset) do
          {:ok, account} ->
            json(conn, %{message: "created", account: account})
          {:error, changeset} ->
            json_error_message(conn, "create error", changeset)
        end
      false ->
        json_error_message(conn, "create error", changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    case Backend.Repo.get(Account, id) do
      nil ->
        json(conn, %{message: "show error: account not found with id = #{id}", error: true})
      account ->
        account = Backend.Repo.preload(account, :address)
        json(conn, %{message: "shown", account: account})
    end
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    case Backend.Repo.get(Account, id) do
      nil ->
        json(conn, %{message: "update error: account not found with id = #{id}", error: true})
      account ->
        changeset = Backend.Repo.preload(account, :address)
        |> Account.update_changeset(account_params)

        case changeset.valid? do
          true ->
            case Backend.Repo.update(changeset) do
              {:ok, account} ->
                not_created_msg = if Enum.count(changeset.changes) == 0, do: "not ", else: ""
                json(conn, %{message: "#{not_created_msg}updated", account: account})
              {:error, changeset} ->
                json_error_message(conn, "update error", changeset)
            end
          false ->
            json_error_message(conn, "update error", changeset)
        end
    end
  end

  def delete(conn, %{"id" => id} = params) do
    case Backend.Repo.get(Account, id) do
      nil ->
        json(conn, %{message: "delete error: account not found with id = #{id}", error: true})
      account ->
        changeset = Backend.Repo.preload(account, :address)
        |> Account.delete_changeset(params)

        case changeset.valid? do
          true ->
            case Backend.Repo.delete(changeset) do
              {:ok, account} ->
                json(conn, %{message: "deleted", account: account})
              {:error, changeset} ->
                json_error_message(conn, "delete error", changeset)
            end
          false ->
            json_error_message(conn, "delete error", changeset)
        end
    end
  end

  def list(conn, %{"limit" => limit} = params) do
    limit = if limit == nil, do: 10
    offset = if params["offset"] == nil, do: 0

    accounts = from(a in Account, limit: ^limit, offset: ^offset, preload: :address)
    |> Backend.Repo.all

    IO.inspect(accounts)

    json(conn, %{message: "listed", accounts: accounts})
  end

  def list(conn, _param) do
    accounts = from(a in Account)
    |> Backend.Repo.all
    |> Backend.Repo.preload(:address)

    json(conn, %{message: "listed", accounts: accounts})
  end

  defp json_error_message(conn, message, changeset) do
    json(conn, %{message: message, error: true, result: Ecto.Changeset.traverse_errors(changeset, &BackendWeb.ErrorHelpers.translate_error/1)})
  end
end
