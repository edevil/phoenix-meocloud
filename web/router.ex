defmodule Pxmeocloud.Router do
  use Pxmeocloud.Web, :router

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

  scope "/", Pxmeocloud do
    pipe_through :browser

    get "/", PageController, :index
    get "/finder", PageController, :finder
  end

  scope "/auth", Pxmeocloud do
    pipe_through :browser

    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

end
