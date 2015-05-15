# mix run priv/repo/seeds.ex

users = [
  %{
    name: "tom",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin"
  },
  %{
    name: "dick",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "normal"
  },
  %{
    name: "harry",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "normal"
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert
end
