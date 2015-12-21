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
  username: "dev",
  password: System.get_env("POSTGRES_PASS"),
  database: "welcome_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Openmaize authentication library configuration
config :openmaize,
  user_model: Welcome.User,
  repo: Welcome.Repo,
  login_dir: "/admin",
  redirect_pages: %{"admin" => "/admin", "user" => "/users", nil => "/"}
