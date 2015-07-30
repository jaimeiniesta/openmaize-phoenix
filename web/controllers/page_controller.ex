defmodule Welcome.PageController do
  use Welcome.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
