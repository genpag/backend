defmodule Backend.Account.User.Create do
  @moduledoc """
  Defines funcions to create a new User in the database
  """

  alias Backend.Account.User
  alias Backend.Repo

  def call(params, address) do
    %User{}
    |> User.changeset(params, address)
    |> Repo.insert()
  end
end
