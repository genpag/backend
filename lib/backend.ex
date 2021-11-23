defmodule Backend do
  alias Backend.Accounts.Create, as: AccountCreate
  alias Backend.Accounts.Delete, as: AccountDelete
  alias Backend.Accounts.Get, as: AccountGet
  alias Backend.Accounts.Update, as: AccountUpdate
  alias Backend.Address.Create, as: AddressCreate

  defdelegate create_account(params), to: AccountCreate, as: :call
  defdelegate delete_account(id) , to: AccountDelete, as: :call
  defdelegate get_account_by_id(id), to: AccountGet, as: :by_id
  defdelegate list_all_accounts(), to: AccountGet, as: :list_all
  defdelegate list_accounts(limit, offset), to: AccountGet, as: :list
  defdelegate update_account(params) , to: AccountUpdate, as: :call
  defdelegate create_address(params), to: AddressCreate, as: :call
end
