# In this example, there are several values for each user.
# The required values are `name`, `password_hash` and `role`.

users = [
  %{
    name: "tom",
    email: "tom@mail.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    bio: "I was born in..."
  },
  %{
    name: "dick",
    email: "dick@mail.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: "I was born in..."
  },
  %{
    name: "harry",
    email: "harry@mail.com",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    bio: "I was born in..."
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert!
end
