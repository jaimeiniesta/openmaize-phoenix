defmodule Welcome.ContactView do
  use Welcome.Web, :view

  def render("index.json", %{users: users}) do
    users
  end

  def render("show.json", %{user: user}) do
    user
  end

  def render(_conn, %{response: response}) do
    response
  end

end
