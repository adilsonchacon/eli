import Config

config :eli, :letmein_base_url, System.get_env("LETMEIN_DEV_BASE_URL") || "http://localhost:4000"
