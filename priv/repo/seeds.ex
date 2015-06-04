# mix run priv/repo/seeds.ex

users = [
  %{
    name: "tom",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    bio: ""
  },
  %{
    name: "dick",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: ""
  },
  %{
    name: "harry",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: ""
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert
end
