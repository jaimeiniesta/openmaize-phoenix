defmodule Welcome.ContactController do
  use Welcome.Web, :controller

  alias Welcome.User

  def index(conn, _params) do
    users = Repo.all(User)
            |> Enum.map(&Map.take(&1, [:id, :name, :email, :role, :bio]))
    render conn, users: users
  end

  def create(conn, %{"user" => user_params}) do
    create_new(conn, Signup.create_user(user_params))
  end

  def create_new(conn, {:ok, user_params}) do
    changeset = User.changeset(%User{}, user_params)
    if changeset.valid? do
      Repo.insert(changeset)
      render conn, response: %{ok: "User created successfully"}
    else
      render conn, response: %{error: "There was a problem"}
    end
  end

  def create_new(conn, {:error, message}) do
    render conn, response: %{error: message}
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id) |> Map.take([:id, :name, :email, :role, :bio])
    render conn, user: user
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)
      render conn, response: %{ok: "User updated successfully"}
    else
      render conn, response: %{error: "There was a problem"}
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)
    render conn, response: %{ok: "User deleted successfully"}
  end

end
