defmodule ConnCase.Helper do

  alias Welcome.Repo
  alias Welcome.User

  @users [
    %{id: 1, name: "Gladys", role: "user", password: "mangoes&gooseberries"},
    %{id: 2, name: "Reg", role: "admin", password: "mangoes&gooseberries"},
    %{id: 3, name: "Tony", role: "user", password: "mangoes&gooseberries"}
  ]

  def add_users do
    for user <- @users do
      %User{} |> User.auth_changeset(user) |> Repo.insert!
    end
  end

end
