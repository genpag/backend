defmodule Backend.RecordsTest do
  use Backend.DataCase

  alias Backend.Records

  describe "address" do
    alias Backend.Records.Address

    @valid_attrs %{city: "some city", complement: "some complement", neighborhood: "some neighborhood", number: 42, postal_code: 42, state: "some state"}
    @update_attrs %{city: "some updated city", complement: "some updated complement", neighborhood: "some updated neighborhood", number: 43, postal_code: 43, state: "some updated state"}
    @invalid_attrs %{city: nil, complement: nil, neighborhood: nil, number: nil, postal_code: nil, state: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_address()

      address
    end

    test "list_address/0 returns all address" do
      address = address_fixture()
      assert Records.list_address() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Records.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Records.create_address(@valid_attrs)
      assert address.city == "some city"
      assert address.complement == "some complement"
      assert address.neighborhood == "some neighborhood"
      assert address.number == 42
      assert address.postal_code == 42
      assert address.state == "some state"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Records.update_address(address, @update_attrs)
      assert address.city == "some updated city"
      assert address.complement == "some updated complement"
      assert address.neighborhood == "some updated neighborhood"
      assert address.number == 43
      assert address.postal_code == 43
      assert address.state == "some updated state"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_address(address, @invalid_attrs)
      assert address == Records.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Records.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Records.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Records.change_address(address)
    end
  end

  describe "account" do
    alias Backend.Records.Account

    @valid_attrs %{cpf: "some cpf", name: "some name"}
    @update_attrs %{cpf: "some updated cpf", name: "some updated name"}
    @invalid_attrs %{cpf: nil, name: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Records.create_account()

      account
    end

    test "list_account/0 returns all account" do
      account = account_fixture()
      assert Records.list_account() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Records.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Records.create_account(@valid_attrs)
      assert account.cpf == "some cpf"
      assert account.name == "some name"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Records.update_account(account, @update_attrs)
      assert account.cpf == "some updated cpf"
      assert account.name == "some updated name"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_account(account, @invalid_attrs)
      assert account == Records.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Records.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Records.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Records.change_account(account)
    end
  end
end
