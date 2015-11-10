defmodule Pxmeocloud.PageController do
  require Logger
  use Pxmeocloud.Web, :controller
  import Pxmeocloud.Router.Helpers

  plug :enforce_auth

  def index(conn, _params) do
    render conn, "index.html"
  end

  def finder(conn, %{"path" => path}) do
    token = get_session(conn, :oauth_token)
    {:ok, %{:body => %{"contents" => contents}}} = OAuth2.AccessToken.get(token, "/1/Metadata/meocloud#{path}", [], [hackney: [:insecure]])
    Logger.debug('Dir #{path} has #{length contents} elements')
    render conn, "finder.html", contents: contents
  end
  def finder(conn, _), do: finder(conn, %{"path" => "/"})

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
