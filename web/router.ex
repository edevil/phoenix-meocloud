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
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Pxmeocloud do
    pipe_through :browser

    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Pxmeocloud do
  #   pipe_through :api
  # end
end
