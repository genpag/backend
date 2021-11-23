defmodule BackendWeb.AccountsView do
    use BackendWeb, :view
    alias Backend.Account

    def render("create.json", %{account: %Account{} = account}) do
        %{
          message: "Account created!",
          account: account
        }
    end

    def render("account.json", %{account: %Account{} = account}), do: %{account: account}

    def render("account_list.json", %{account: list}), do: %{account: list}


  end
