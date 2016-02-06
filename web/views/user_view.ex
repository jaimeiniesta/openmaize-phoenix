defmodule Welcome.UserView do
  use Welcome.Web, :view

  def user_name(user) do
    if user[:email] do
      user[:email]
      |> String.split("@")
      |> hd
      |> String.capitalize
    else
      "The Black Knight"
    end
  end
end
