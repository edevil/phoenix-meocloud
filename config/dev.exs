use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :pxmeocloud, Pxmeocloud.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :pxmeocloud, Pxmeocloud.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
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

config :pxmeocloud, OauthSettings,
  client_id: System.get_env("OAUTH_CLIENT_ID"),
  client_secret: System.get_env("OAUTH_CLIENT_SECRET"),
  redirect_uri: "http://localhost:4000/auth/callback",
  authorize_url: "https://disco.dev.sapo.pt/oauth2/authorize",
  token_url: "https://disco.dev.sapo.pt/oauth2/token",
  site: "https://api.disco.dev.sapo.pt"
