defmodule PeriscopeTester.MixProject do
  use Mix.Project

  def project do
    [
      app: :periscope_tester,
      version: "0.1.0",
      elixir: "~> 1.13",
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
      {:floki, ">= 0.30.0", only: :test},
      {:periscope, ">= 0.0.0"},
      {:periscope_test_app, path: "./priv/periscope_test_app", only: [:test, :dev]}
    ]
  end
end
