defmodule Welcome.AdminController do
  use Welcome.Web, :controller

  alias Welcome.User
  alias Openmaize.Signup

  plug :scrub_params, "user" when action in [:create]
  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"user" => user_params}) do
    create_new(conn, Signup.create_user(user_params))
  end

  def create_new(conn, {:ok, user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: admin_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create_new(conn, {:error, message}) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: admin_path(conn, :new))
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: admin_path(conn, :index))
  end
end
