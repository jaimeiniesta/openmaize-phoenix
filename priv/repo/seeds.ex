# mix run priv/repo/seeds.ex

users = [
  %{
    name: "tom",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    bio: "I was born in..."
  },
  %{
    name: "dick",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: "I was born in..."
  },
  %{
    name: "harry",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: "I was born in..."
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert
end
