defmodule ConnCase.Helper do

  alias Welcome.Repo
  alias Welcome.User

  @users [
    %{id: 1, email: "gladys@mail.com", role: "user", password: "mangoes&g0oseberries"},
    %{id: 2, email: "reg@mail.com", role: "admin", password: "mangoes&g0oseberries"},
    %{id: 3, email: "tony@mail.com", role: "user", password: "mangoes&g0oseberries"}
  ]

  def add_users do
    for user <- @users do
      %User{} |> User.auth_changeset(user, "") |> Repo.insert!
    end
  end

end
