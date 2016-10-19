defmodule Elixometer.Mixfile do
  use Mix.Project

  def project do
    [app: :elixometer,
     version: "1.2.1",
     elixir: ">= 1.0.0",
     description: description,
     source_url: project_url,
     homepage_url: project_url,
     package: package,
     deps: deps,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test,
                         "coveralls.detail": :test,
                         "coveralls.post": :test],
     elixirc_paths: elixirc_paths(Mix.env),
     ]
  end

  def application do
     [mod: {Elixometer.App, []},
      applications: [:exometer_core, :pobox],
      env: default_config(Mix.env)
     ]
  end

  def default_config(:test) do
     [update_frequency: 20]
  end

  def default_config(_) do
     [update_frequency: 1_000]
  end

  defp deps do
    [
      {:exometer_core, github: "Feuerlabs/exometer_core", ref: "9206b28d045b395abd1b86cc794223ec9aeeb0ea"},
      {:edown, github: "uwiger/edown", tag: "0.7", override: true},
      {:meck, github: "eproxus/meck", tag: "0.8.2", override: true},
      {:excoveralls, "~>0.5.4", only: :test},
      {:pobox, "~>1.0.2"}
    ]
  end

  defp description do
     """
     Elixometer is a light wrapper around exometer that defines and subscribes metrics automatically
to   the configured reporter.
     """
  end

  defp project_url do
     """
     https://github.com/pinterest/elixometer
     """
  end

  defp package do
     [files: ["config", "lib", "mix.exs", "mix.lock", "README.md", "LICENSE"],
      maintainers: ["Jon Parise", "Steve Cohen"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => project_url}
     ]
  end

  defp elixirc_paths(:test) do
    ["lib", "test/support"]
  end

  defp elixirc_paths(_) do
    ["lib"]
  end

end
