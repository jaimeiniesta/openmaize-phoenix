defmodule ConnCase.Helper do

  alias Welcome.{Repo, User}

  @users [
    %{id: 1, email: "gladys@mail.com", role: "user", password: "mangoes&g0oseberries"},
    %{id: 2, email: "reg@mail.com", role: "admin", password: "mangoes&g0oseberries"},
    %{id: 3, email: "tony@mail.com", role: "user", password: "mangoes&g0oseberries"}
  ]

  def add_users do
    key = "pu9-VNdgE8V9qZo19rlcg3KUNjpxuixg"
    for user <- @users do
      %User{}
      |> User.auth_changeset(user, key)
      |> User.reset_changeset(user, key)
      |> Repo.insert!
    end
  end

end
