defmodule BackendWeb.AccountController do
  use BackendWeb, :controller
  alias Backend.Records.Account

  def create(conn, %{"account" => account_params}) do
    IO.inspect(account_params)
    changeset = Account.changeset(%Account{}, account_params)

    IO.inspect(changeset)
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

  defp json_error_message(conn, message, changeset) do
    json(conn, %{message: message, error: true, result: Ecto.Changeset.traverse_errors(changeset, &BackendWeb.ErrorHelpers.translate_error/1)})
  end
end
