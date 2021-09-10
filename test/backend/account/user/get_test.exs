defmodule Backend.Account.User.GetTest do
  @moduledoc false

  import Backend.Factory
  use Backend.DataCase, async: true

  alias Backend.Accounts

  setup do
    user_1 = insert(:user)
    user_2 = insert(:user)
    user_3 = insert(:user)

    %{user_1: user_1, user_2: user_2, user_3: user_3}
  end

  test "gets an user from the database", %{user_1: user} do
    {:ok, user_db} = Accounts.get_user(user.id)

    assert not is_nil(user)
    assert user == user_db
  end

  test "gets all users from the database", %{user_1: user_1, user_2: user_2, user_3: user_3} do
    params = %{"limit" => "10", "offset" => "0"}
    {:ok, user_db} = Accounts.get_users(params)

    assert not is_nil(user_db)
    assert Enum.member?(user_db, user_1)
    assert Enum.member?(user_db, user_2)
    assert Enum.member?(user_db, user_3)
  end
end
