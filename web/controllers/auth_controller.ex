defmodule Pxmeocloud.AuthController do
  use Pxmeocloud.Web, :controller

  def index(conn, _params) do
  	redirect conn, external: MEOCloud.authorize_url!
  end

  def callback(conn, %{"code" => code}) do
  	token = MEOCloud.get_token!(code: code)
    conn
    |> put_session(:oauth_token, token)
    |> redirect to: page_path(conn, :index)
  end

end
