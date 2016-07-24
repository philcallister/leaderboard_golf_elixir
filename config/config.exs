# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :leaderboard_golf,
  ecto_repos: [LeaderboardGolf.Repo]

# Configures the endpoint
config :leaderboard_golf, LeaderboardGolf.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pi/uMZHEczsI8NnNXZDZClkQYmrcEKWqCAua1T05AL29YB6dYlRHC4WbkRSHl3vg",
  render_errors: [view: LeaderboardGolf.ErrorView, accepts: ~w(json)],
  pubsub: [name: LeaderboardGolf.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
