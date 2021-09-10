defmodule BackendWeb.FallbackController do
  use BackendWeb, :controller

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> json("Unauthorized")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> json("Not found")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: message})
  end
end
