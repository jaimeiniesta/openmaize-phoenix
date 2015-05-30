defmodule Welcome.AdminController do
  use Welcome.Web, :controller

  alias Welcome.User

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "login.html", changeset: changeset
  end

end
