# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :practica_liveview,
  ecto_repos: [PracticaLiveview.Repo]

# Configures the endpoint
config :practica_liveview, PracticaLiveviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kOTvVC/WY6VxZs8UfT3IzQYHtbXqVmvElqP8AOwtjnNdfz371H0SSEq6K46EWgag",
  render_errors: [view: PracticaLiveviewWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PracticaLiveview.PubSub,
  live_view: [signing_salt: "UjadrZXMm54YOJ7mqCLERxIYbkJrIP8n"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
