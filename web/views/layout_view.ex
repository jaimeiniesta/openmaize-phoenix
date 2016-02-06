defmodule Welcome.LayoutView do
  use Welcome.Web, :view

  def user_name(user) do
    if user[:email] do
      user[:email]
      |> String.split("@")
      |> hd
      |> String.capitalize
    else
      "Intruder"
    end
  end
end
