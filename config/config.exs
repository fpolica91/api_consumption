# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :consuming_apis,
  ecto_repos: [ConsumingApis.Repo]

# Configures the endpoint
config :consuming_apis, ConsumingApisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HkA8sbfgZ0brKkHk4fpuFSd12JGrl5LJbv9WTxZdRdAXgRblXETH97PMtoSSs7Bj",
  render_errors: [view: ConsumingApisWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ConsumingApis.PubSub,
  live_view: [signing_salt: "kh0FMwx7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
