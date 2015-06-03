defmodule Welcome.AdminController do
  use Welcome.Web, :controller

  alias Welcome.User
  alias Openmaize.Signup

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "login.html", changeset: changeset
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
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
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create_new(conn, {:error, message}) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: user_path(conn, :new))
  end
end
