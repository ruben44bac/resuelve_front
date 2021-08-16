# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# config :resuelvef,
#   ecto_repos: [Resuelvef.Repo]

# Configures the endpoint
config :resuelvef, ResuelvefWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0dcrgrDTHN3xRtbxQLE+CLwoPKZvldBzEIyvAqB1jInhWzAKW4P8/16uKO8oEvqz",
  render_errors: [view: ResuelvefWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Resuelvef.PubSub,
  live_view: [signing_salt: "TGjL6rcQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
