use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :welcome, Welcome.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :welcome, Welcome.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :welcome, Welcome.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: System.get_env("POSTGRES_PASS"),
  database: "welcome_dev",
  hostname: "localhost",
  pool_size: 10

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
