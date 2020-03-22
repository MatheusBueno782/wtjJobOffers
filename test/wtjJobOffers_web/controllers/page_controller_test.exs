defmodule WtjJobOffersWeb.PageControllerTest do
  use WtjJobOffersWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert conn.resp_body == "Welcome to offers API!"
  end
end
