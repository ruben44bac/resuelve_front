use Mix.Config

config :resuelvef, ResuelvefWeb.Endpoint,
  load_from_system_env: true,
  http: [port: {:system, "PORT"}],
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "${APP_NAME}.gigalixirapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :resuelvef, :endpoint,
  ghibli: "https://ghibliapi.herokuapp.com/",
  harvar: "https://api.harvardartmuseums.org/object?apikey=b2b107bb-64f0-4651-99ff-d3b0e15fceb7"
