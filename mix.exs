defmodule Mm1Codec.MixProject do
  use Mix.Project

  def project do
    [
      app: :mm1_codec,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]


  def application do
    [
      extra_applications: [:logger],
      mod: {Mm1Codec.Application, []}
    ]
  end

  defp deps do
    [
      {:mix_test_watch, "~>   0.9", only: :dev, runtime: false},
      {:ok_computer,   path: "../ok_computer"},
#      {:ok_computer,    "~> 0.1.0"},
    ]
  end
end
