defmodule Eli.MixProject do
  use Mix.Project

  @source_url "https://github.com/adilsonchacon/eli"
  @version "0.1.9"

  def project do
    [
      app: :eli,
      version: @version,
      source_url: @source_url,
      description: description(),
      package: package(),
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:req, "~> 0.5"},
      {:mox, "~> 1.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Library for Letmein Integration."
  end

  defp package() do
    [
      name: "eli",
      files: ~w(lib mix.exs README.md LICENSE config),
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
