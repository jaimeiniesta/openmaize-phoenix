# In this example, there are several values for each user.
# The required values are `name`, `password_hash` and `role`.

users = [
  %{
    email: "tom@mail.com",
    name: "tom",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  },
  %{
    email: "dick@mail.com",
    name: "dick",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  },
  %{
    email: "harry@mail.com",
    name: "harry",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert!
end
