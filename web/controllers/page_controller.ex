defmodule Pxmeocloud.PageController do
  require Logger
  use Pxmeocloud.Web, :controller
  import Pxmeocloud.Router.Helpers

  plug :enforce_auth

  def index(conn, _params) do
    render conn, "index.html"
  end

  defp enforce_auth(conn, _params) do
    token = get_session(conn, :oauth_token)
    if token do
      {:ok, %{:body => %{"display_name" => display_name}}} = OAuth2.AccessToken.get(token, "/1/Account/Info", [], [hackney: [:insecure]])
      Logger.debug("User authenticated: #{display_name}")
      assign(conn, :display_name, display_name)
    else
      Logger.debug("Connection not authenticated")
      conn
      |> redirect(to: auth_path(conn, :index))
      |> halt()
    end
  end
end
