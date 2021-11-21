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

  def list(conn, params) do
    limit = params["limit"]
    offset = params["offset"]

    IO.inspect(limit)
    IO.inspect(offset)

    case limit do
      nil ->
        case offset do
          nil ->
            from(a in Account, preload: :address)
            |> json_send_list(conn)
          _ ->
            from(a in Account, offset: ^offset, preload: :address)
            |> json_send_list(conn)
        end

      _ ->
        case offset do
          nil ->
            from(a in Account, limit: ^limit, preload: :address)
            |> json_send_list(conn)
          _ ->
            from(a in Account, limit: ^limit, offset: ^offset, preload: :address)
            |> json_send_list(conn)
        end
    end
  end

  defp json_send_list(accounts, conn) do
    accounts = Backend.Repo.all(accounts)
    json(conn, %{message: "listed", accounts: accounts})
  end

  defp json_error_message(conn, message, changeset) do
    json(conn, %{message: message, error: true, result: Ecto.Changeset.traverse_errors(changeset, &BackendWeb.ErrorHelpers.translate_error/1)})
  end
end
