defmodule Backend.Accounts do
  @moduledoc """
  Context delegations for the Accounts context.
  """

  alias Backend.Account.{
    Address,
    User
  }

  defdelegate create_user(params, address),
    to: User.Create,
    as: :call

  defdelegate get_user(search_terms),
    to: User.Get,
    as: :call

  defdelegate get_users(params),
    to: User.Get,
    as: :call

  defdelegate update_user(user, params, address \\ nil),
    to: User.Update,
    as: :call

  defdelegate delete_user(user),
    to: User.Delete,
    as: :call

  defdelegate load_address(params),
    to: Address.LoadPostalCode,
    as: :call
end
