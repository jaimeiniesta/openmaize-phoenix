defmodule ConnCase.Helper do

  alias Welcome.Repo
  alias Welcome.User

  @users [
    %{id: 1, name: "Gladys", role: "user", password: "mangoes&g0oseberries"},
    %{id: 2, name: "Reg", role: "admin", password: "mangoes&g0oseberries"},
    %{id: 3, name: "Tony", role: "user", password: "mangoes&g0oseberries"}
  ]

  def add_users do
    for user <- @users do
      %User{} |> User.auth_changeset(user) |> Repo.insert!
    end
  end

end
