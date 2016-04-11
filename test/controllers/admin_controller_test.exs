defmodule Welcome.AdminControllerTest do
  use Welcome.ConnCase

  import OpenmaizeJWT.Create
  alias Welcome.Repo
  alias Welcome.User

  @valid_attrs %{email: "bill@mail.com", password: "^hEsdg*F899", role: "user"}
  @invalid_attrs %{email: "albert@mail.com", password: "password"}

  {:ok, user_token} = %{id: 2, email: "reg@mail.com", role: "admin"}
                      |> generate_token({0, 86400})
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

  test "creates and returns user when data is valid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == admin_path(conn, :index)
    assert Repo.get_by(User, %{email: "bill@mail.com"})
  end

  test "does not create user when data is invalid", %{conn: conn} do
    conn = post conn, admin_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200)
    refute Repo.get_by(User, %{email: "albert@mail.com"})
  end

  test "delete user", %{conn: conn} do
    user = Repo.get(User, 3)
    conn = conn
    |> delete(admin_path(conn, :delete, user))
    assert redirected_to(conn) == admin_path(conn, :index)
    refute Repo.get(User, user.id)
  end

end
