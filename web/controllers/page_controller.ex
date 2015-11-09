defmodule Pxmeocloud.PageController do
  use Pxmeocloud.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
