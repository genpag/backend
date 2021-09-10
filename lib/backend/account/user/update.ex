defmodule Backend.Account.User.Update do
  @moduledoc """
  Defines funcions to update User in database
  """

  alias Backend.Account.User
  alias Backend.Repo

  def call(user, params, address) do
    params = validate_params(params)

    user
    |> User.changeset(params, address)
    |> Repo.update()
  end

  defp validate_params(params), do: Map.delete(params, "cpf")
end
