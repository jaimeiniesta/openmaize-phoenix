defmodule Welcome.ContactView do
  use Welcome.Web, :view

  def render("index.json", %{users: users}) do
    users
  end

end
