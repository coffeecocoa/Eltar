# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eltar,
  ecto_repos: [Eltar.Repo]

# Configures the endpoint
config :eltar, EltarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G/2j8fWsb5RxPHtHoIYJmZGjJcwKk6YTf/tR2IP6zVweAWiKQeU65nfVUpFgV9yR",
  render_errors: [view: EltarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eltar.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "____Github_ID______",
  client_secret: "____Github_Secret_____"

config :scrivener_html,
  routes_helper: EltarWeb.Router.Helpers