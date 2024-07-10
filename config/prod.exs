import Config

config :eli, :letmein_base_url, System.get_env("LETMEIN_BASE_URL") || "http://localhost:400"
