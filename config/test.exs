use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :welcome, Welcome.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :welcome, Welcome.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "welcome_test",
  size: 1,
  max_overflow: 0

# Openmaize authentication library configuration
config :openmaize,
  user_model: Welcome.User,
  repo: Welcome.Repo,
  crypto: :bcrypt,
  login_dir: "admin",
  redirect_pages: %{"admin" => "/admin", "user" => "/users", nil => "/"},
  protected: %{"/admin" => ["admin"],
    "/users" => ["admin", "user"],
    "/users/:id" => ["admin", "user"]},
  storage_method: "cookie",
  secret_key: "you will never guess",
  token_validity: 600
