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

# Configure your database
config :welcome, Welcome.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: System.get_env("POSTGRES_PASS"),
  database: "welcome_dev"

# Openmaize authentication library configuration
config :openmaize,
  user_model: Welcome.User,
  repo: Welcome.Repo,
  login_dir: "/admin",
  redirect_pages: %{"admin" => "/admin", "user" => "/users", nil => "/"},
  protected: %{"/admin" => ["admin"],
    "/users" => ["admin", "user"],
    "/users/:id" => ["user"],
    "/api/users" => ["admin"]
  }
