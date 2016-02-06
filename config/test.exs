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
# For more information about configuration, see the documentation
# for the Openmaize.Config module.
config :openmaize,
  user_model: Welcome.User,
  repo: Welcome.Repo,

  # Different roles can be redirected to different locations after login. The following
  # is a map from role to destination. If you add new roles, you should update this map.
  # 
  # The `"login"` key describes where to go after a failed login.
  # The `"logout"` key describes where to go after logging out.
  redirect_pages: %{"admin" => "/admin", "user" => "/users",
    "login" => "/login", "logout" => "/"}

# Configure mailgun
config :welcome,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")
