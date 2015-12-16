defmodule Welcome.PageControllerTest do
  use Welcome.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "You have beautiful thighs!"
  end
end
