defmodule Welcome.UserController do
  use Welcome.Web, :controller

  alias Welcome.User
  alias Comeonin.Bcrypt

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.html", users: users)
  end

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "login.html", changeset: changeset
  end

  def login_user(conn, _params) do
    %{"name" => name, "password" => password} = Map.get(conn.params, "user")
    user = check_login(name, password)
    if user do
      conn
      |> put_flash(:info, "Logged in successfully.")
      |> redirect(to: user_path(conn, :show, user))
    else
      conn
      |> put_flash(:error, "Invalid credentials")
      |> redirect(to: user_path(conn, :login))
    end
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
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

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  defp check_login(name, password) do
    from(user in User,
    where: user.name == ^name,
    select: user)
    |> Repo.one
    |> check_user(password)
  end

  defp check_user(nil, _), do: Bcrypt.dummy_checkpw
  defp check_user(user, password) do
    Bcrypt.checkpw(password, user.password_hash) and user
  end
end
