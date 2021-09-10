defmodule Backend.Account.User.CreateTest do
  @moduledoc false

  import Backend.Factory
  use Backend.DataCase, async: true

  alias Backend.Accounts

  test "adds a new user to the database" do
    user = insert(:user)
    {:ok, user_db} = Accounts.get_user(user.id)

    assert not is_nil(user)
    assert user == user_db
  end
end
