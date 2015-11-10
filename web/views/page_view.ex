defmodule Pxmeocloud.PageView do
  use Pxmeocloud.Web, :view

  def current_user_name(conn) do
    conn.assigns[:display_name]
  end
end
