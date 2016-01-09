defmodule Welcome.UserView do
  use Welcome.Web, :view

  def user_name(user) do
    if user[:name] do
      String.capitalize(user[:name])
    else
      "mate"
    end
  end
end
