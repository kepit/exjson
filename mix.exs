defmodule ExJSON.Mixfile do
  use Mix.Project

  def project do
    [ app: :exjson,
      version: "0.2.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{:hex, github: "rjsamson/hex"}]
  end
end
