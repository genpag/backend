defmodule BackendWeb.AccountControllerTest do
  use BackendWeb.ConnCase, async: true

  import Mox

  describe "create/2" do
    setup :verify_on_exit!

    @success_with_address_params %{
      "cpf" => "1",
      "name" => "Name",
      "address" => %{
        "street" => Faker.Address.PtBr.street_address(),
        "number" => "100",
        "complement" => Faker.Address.PtBr.secondary_address(),
        "neighborhood" => Faker.Address.PtBr.neighborhood(),
        "city" => Faker.Address.PtBr.city(),
        "state" => Faker.Address.PtBr.state_abbr(),
        "postal_code" => "12345678"
      }
    }

    @success_params %{
      "cpf" => "1",
      "name" => "Name",
      "address" => %{
        "number" => "1",
        "postal_code" => "12345678"
      }
    }

    @success_mock_via_cep %{
      "street" => Faker.Address.PtBr.street_address(),
      "complement" => Faker.Address.PtBr.secondary_address(),
      "neighborhood" => Faker.Address.PtBr.neighborhood(),
      "city" => Faker.Address.PtBr.city(),
      "state" => Faker.Address.PtBr.state_abbr()
    }

    test "return create success with address API", %{conn: conn} do
      conn =
        conn
        |> post(Routes.account_path(conn, :create), @success_with_address_params)

      assert %{"id" => _} = json_response(conn, 201)["data"]
    end

    test "return create success", %{conn: conn} do
      expect(Backend.Services.Apis.MockViaCepApi, :get_address_by_postal_code, fn _ ->
        {:ok, @success_mock_via_cep}
      end)

      conn =
        conn
        |> post(Routes.account_path(conn, :create), @success_params)

      assert %{"id" => _} = json_response(conn, 201)["data"]
    end

    test "return invalid create when postal code not found", %{conn: conn} do
      expect(Backend.Services.Apis.MockViaCepApi, :get_address_by_postal_code, fn _ ->
        {:error, :not_found}
      end)

      conn =
        conn
        |> post(Routes.account_path(conn, :create), @success_params)

      assert %{"error" => _} = json_response(conn, 422)
    end

    test "return invalid create when there is an error in the request to the API", %{conn: conn} do
      expect(Backend.Services.Apis.MockViaCepApi, :get_address_by_postal_code, fn _ ->
        {:error, :bad_request}
      end)

      conn =
        conn
        |> post(Routes.account_path(conn, :create), @success_params)

      assert %{"error" => _} = json_response(conn, 422)
    end
  end
end
