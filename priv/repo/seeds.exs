# In this example, there are several values for each user.
# The required values are `username`, `password_hash` and `role`.

users = [
  %{
    email: "tom@mail.com",
    username: "tom",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "admin",
    otp_required: true,
    otp_secret: Comeonin.Otp.gen_secret,
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  },
  %{
    email: "dick@mail.com",
    username: "dick",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  },
  %{
    email: "harry@mail.com",
    username: "harry",
    password_hash: Comeonin.Bcrypt.hashpwsalt("mangoes"),
    role: "user",
    confirmed_at: Ecto.DateTime.utc,
    bio: "I was born in..."
  }
]

for user <- users do
  Map.merge(%Welcome.User{}, user) |> Welcome.Repo.insert!
end
