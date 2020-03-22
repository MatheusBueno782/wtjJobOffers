defmodule WtjJobOffersWeb.Router do
  use WtjJobOffersWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WtjJobOffersWeb do
    pipe_through :api
    #for test purposes only
    resources "/offers", OfferController, except: [:new, :edit]
  end

  scope "/", WtjJobOffersWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

end
