defmodule Backend.Account.User.DeleteTest do
  @moduledoc false

  import Backend.Factory
  use Backend.DataCase, async: true

  alias Backend.Accounts

  setup do
    user = insert(:user)

    %{user: user}
  end

  test "deletes an user from the database", %{user: user} do
    {:ok, _} = Accounts.delete_user(user)
    user_db = Accounts.get_user(user.id)

    assert {:error, :not_found} == user_db
  end
end
