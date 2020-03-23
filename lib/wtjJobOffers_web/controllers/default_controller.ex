defmodule WtjJobOffersWeb.DefaultController do
  use WtjJobOffersWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to offers API!")
  end
end
