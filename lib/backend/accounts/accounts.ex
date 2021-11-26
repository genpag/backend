defmodule Backend.Accounts do
  import Ecto.Query, warn: false

  def via_cep, do: Application.get_env(:backend, :via_cep_api)

  alias Backend.Services.Repo.AccountsRepo

  def get_account(id) do
    case AccountsRepo.get_account(id) do
      {:ok, account} -> {:ok, account}
      _ -> {:error, :account_not_found}
    end
  end

  def create(params) do
    address_params = get_address_field(params)
    postal_code_params = get_postal_code_field(params)

    address =
      if address_is_empty?(address_params) do
        case via_cep().get_address_by_postal_code(postal_code_params) do
          {:ok, response} -> {:ok, response}
          {:error, :not_found} -> {:ok, address_params}
          {:error, :bad_request} -> {:ok, address_params}
        end
      else
        {:ok, address_params}
      end

    case address do
      {:ok, address} ->
        address = Map.merge(address, address_params)

        Map.put(params, "address", address)
        |> AccountsRepo.create_account()
      _ ->
        {:error, :error_postal_code_not_found}
    end
  end

  @address_empty_values [nil, ""]
  defp address_is_empty?(nil), do: true

  defp address_is_empty?(address) do
    address["street"] in @address_empty_values ||
    address["complement"] in @address_empty_values ||
    address["neighborhood"] in @address_empty_values ||
    address["city"] in @address_empty_values ||
    address["state"] in @address_empty_values ||
    address["postal_code"] in @address_empty_values
  end

  def get_address_field(params) do
    address = params["address"]

    case address do
      nil -> %{}
      _ -> address
    end
  end

  def get_postal_code_field(params) do
    postal_code = params["address"]["postal_code"]

    case postal_code do
      nil -> ""
      _ -> postal_code
    end
  end
end
