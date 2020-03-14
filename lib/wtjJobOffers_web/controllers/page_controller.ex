defmodule WtjJobOffersWeb.PageController do
  use WtjJobOffersWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
