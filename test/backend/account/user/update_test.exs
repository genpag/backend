defmodule Backend.Account.User.UpdateTest do
  @moduledoc false

  import Backend.Factory
  use Backend.DataCase, async: true

  alias Backend.Accounts

  setup do
    user = insert(:user)
    %{user: user}
  end

  test "updates a user in the database", %{user: user} do
    Accounts.update_user(user, %{"name" => "updated_name"})
    {:ok, user_db} = Accounts.get_user(user.id)

    assert not is_nil(user)
    assert user_db.name == "updated_name"
  end
end
