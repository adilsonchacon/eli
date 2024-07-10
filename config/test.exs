import Config

config :eli, :letmein_base_url, System.get_env("LETMEIN_TEST_BASE_URL") || "http://localhost:400"
