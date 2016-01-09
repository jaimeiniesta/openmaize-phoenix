defmodule Welcome.PageController do
  use Welcome.Web, :controller

  plug Openmaize.Login when action in [:login_user]
  # If you want to use email to identify the user, remove the above line
  # and uncomment the line below
  #plug Openmaize.Login, [unique_id: :email] when action in [:login_user]
  plug Openmaize.Logout when action in [:logout]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end
end
