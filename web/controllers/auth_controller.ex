defmodule Pxmeocloud.AuthController do
  use Pxmeocloud.Web, :controller

  def index(conn, _params) do
  	redirect conn, external: MEOCloud.authorize_url!
  end

  def callback(conn, %{"code" => code}) do
  	token = MEOCloud.get_token!(code: code)

  	OAuth2.AccessToken.get(token, "/1/Account/Info", [], [hackney: [:insecure]])
  	|> inspect
  	|> IO.puts
  	redirect conn, to: "/"
  end
end
