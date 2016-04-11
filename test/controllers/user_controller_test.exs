defmodule Welcome.UserControllerTest do
  use Welcome.ConnCase

  import OpenmaizeJWT.Create
  alias Welcome.Repo
  alias Welcome.User

  @valid_attrs %{email: "bill@mail.com", password: "^hEsdg*F899", role: "user"}
  @invalid_attrs %{email: "albert@mail.com", password: "password"}

  {:ok, user_token} = %{id: 1, email: "gladys@mail.com", role: "user"}
                      |> generate_token({0, 86400})
  @user_token user_token

  setup do
    conn = conn()
    |> put_req_cookie("access_token", @user_token)
    {:ok, conn: conn}
  end

  test "GET /users for authorized user", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "GET /users redirect for unauthorized user" do
    conn = conn() |> get(user_path(conn, :index))
    assert redirected_to(conn) == login_path(conn, :login)
  end

  test "GET /users/:id", %{conn: conn} do
    user = Repo.get(User, 1)
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200)
  end

  test "GET /users/:id/edit", %{conn: conn} do
    user = Repo.get(User, 1)
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200)
  end

  test "GET /users/:id/edit redirect for other user", %{conn: conn} do
    user = Repo.get(User, 2)
    conn = get conn, user_path(conn, :edit, user)
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "PUT /users/:id with valid data", %{conn: conn} do
    user = Repo.get(User, 1)
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "PUT /users/:id with invalid data", %{conn: conn} do
    user = Repo.get(User, 1)
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert redirected_to(conn) == user_path(conn, :index)
  end

end
