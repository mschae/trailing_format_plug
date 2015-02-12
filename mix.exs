defmodule TrailingFormatPlug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :trailing_format_plug,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      deps: deps,
      package: [
        contributors: ["Michael Schaefermeyer"],
        licenses: ["MIT"],
        links: %{"Github" => "http://github.com/mschae/trailing_format_plug"}
      ],
      description: description
     ]
  end

  def application do
    [applications: [:logger, :cowboy]]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "> 0.8.0"}
    ]
  end

  defp description do
    """
    An elixir plug to support legacy APIs that use a rails-like trailing
    format: http://api.dev/resources.format
    """
  end
end
