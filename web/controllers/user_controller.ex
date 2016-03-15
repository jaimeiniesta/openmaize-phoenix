defmodule Welcome.UserController do
  use Welcome.Web, :controller

  import Welcome.Authorize
  alias Welcome.User

  plug :scrub_params, "user" when action in [:update]
  plug :id_check when action in [:show, :edit, :update]

  def action(conn, _), do: authorize_action conn, ["admin", "user"], __MODULE__

  def index(conn, _params, _user) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}, _user) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}, _user) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}, _user) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User page updated successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
