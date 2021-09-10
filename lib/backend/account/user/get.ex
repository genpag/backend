defmodule Backend.Account.User.Get do
  @moduledoc """
  Defines funcions to get User from the database
  """

  import Ecto.Query

  alias Backend.Account.User
  alias Backend.Repo

  def call(id) when is_bitstring(id) do
    {id, _} = Integer.parse(id)
    call(id)
  end

  def call(id) when is_integer(id) do
    User
    |> Repo.get(id)
    |> handle_response()
  end

  def call(params) when is_map(params) do
    limit = String.to_integer(params["limit"] || "10")
    offset = String.to_integer(params["offset"] || "0")

    users =
      User
      |> limit(^limit)
      |> offset(^offset)
      |> Repo.all()

    {:ok, users}
  end

  defp handle_response(nil), do: {:error, :not_found}
  defp handle_response(user), do: {:ok, user}
end
