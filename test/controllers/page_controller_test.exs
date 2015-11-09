defmodule Pxmeocloud.PageControllerTest do
  use Pxmeocloud.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
