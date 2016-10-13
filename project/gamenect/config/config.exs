# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gamenect,
  ecto_repos: [Gamenect.Repo]

# Configures the endpoint
config :gamenect, Gamenect.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FCobFi7MpalH6TIyqffWP/cEDdt/7si62kp4SU7NVAV/BioRPZ0GG6D0oH3hXtV1",
  render_errors: [view: Gamenect.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gamenect.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :gamenect, Gamenect.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailgun.org",
  port: 25,
  username: "postmaster@sandbox2d876dea6fe0444ca5b58499d836b588.mailgun.org",
  password: "41a05b9bf19ec145d43bb20741dfab1b",
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 3

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "MyApp",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "6493b6ddcd8f032988e42de10e5f68082dd74f95efd445190fa7a6f858268d53",
  serializer: Gamenect.GuardianSerializer
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
