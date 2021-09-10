defmodule Backend.Account.User.Delete do
  @moduledoc """
  Defines funcions to delete a User in the database
  """

  alias Backend.Repo

  def call(user) do
    user
    |> Repo.delete()
  end
end
