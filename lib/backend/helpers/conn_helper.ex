defmodule Backend.Helpers.ConnHelper do
  alias Plug.Conn

  @content_type_default "application/json"

  def ok(conn) do
    conn
    |> Conn.put_resp_content_type(@content_type_default)
    |> Conn.put_status(Conn.Status.code(:ok))
  end

  def created(conn) do
    conn
    |> Conn.put_resp_content_type(@content_type_default)
    |> Conn.put_status(Conn.Status.code(:created))
  end

  def unprocessable_entity(conn) do
    conn
    |> Conn.put_resp_content_type(@content_type_default)
    |> Conn.put_status(Conn.Status.code(:unprocessable_entity))
  end

  def not_found(conn) do
    conn
    |> Conn.put_resp_content_type(@content_type_default)
    |> Conn.send_resp(Conn.Status.code(:not_found), "")
    |> Conn.halt()
  end

  def internal_server_error(conn) do
    conn
    |> Conn.put_resp_content_type(@content_type_default)
    |> Conn.send_resp(Conn.Status.code(:internal_server_error), "")
    |> Conn.halt()
  end
end
