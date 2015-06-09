defmodule Welcome.ContactController do
  use Welcome.Web, :controller

  alias Welcome.User

  plug :action

  def index(conn, _params) do
    users = Repo.all(User)
            |> Enum.map(&Map.take(&1, [:id, :name, :email, :role, :bio]))
    render conn, users: users
  end

end
