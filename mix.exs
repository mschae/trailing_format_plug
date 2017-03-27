defmodule TrailingFormatPlug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :trailing_format_plug,
      version: "0.0.6",
      elixir: ">= 1.0.0",
      deps: deps(),
      package: [
        maintainers: ["Michael Schaefermeyer"],
        licenses: ["Apache 2.0"],
        links: %{"Github" => "http://github.com/mschae/trailing_format_plug"}
      ],
      description: description()
     ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:plug, "> 0.12.0"},

      {:ex_doc, "~> 0.14.3", only: [:dev]}
    ]
  end

  defp description do
    """
    An elixir plug to support legacy APIs that use a rails-like trailing
    format: http://api.dev/resources.format
    """
  end
end
