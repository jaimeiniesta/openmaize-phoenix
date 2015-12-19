defmodule Welcome.AdminControllerTest do
  use Welcome.ConnCase

  import Openmaize.Token.Create

  {:ok, user_token} = %{id: 2, name: "Reg", role: "admin"} |> generate_token({0, 86400})
  @user_token user_token

  setup do
    conn = conn()
    |> put_req_cookie("access_token", @user_token)
    {:ok, conn: conn}
  end

  test "GET /admin for authorized user", %{conn: conn} do
    conn = get conn, admin_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "GET /admin redirect for unauthorized user" do
    conn = conn() |> get(admin_path(conn, :index))
    assert redirected_to(conn) == login_path(conn, :login)
  end
end
