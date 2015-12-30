defmodule Welcome.AdminController do
  use Welcome.Web, :controller

  import Openmaize.AccessControl

  # only users with the admin role can access resources in this module
  plug :authorize, roles: ["admin"]

  def index(conn, _params) do
    render conn, "index.html"
  end
end
