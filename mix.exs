defmodule Title.MixProject do
  use Mix.Project

  @version "0.2.0"
  @url "https://github.com/tverlaan/titlex"

  def project do
    [
      app: :titlex,
      version: @version,
      elixir: "~> 1.10",
      name: "Title",
      description:
        "Capitalize your titles like a professional! A title capitalization library for Elixir.",
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs() do
    [
      main: "Title",
      source_ref: "v#{@version}",
      source_url: @url
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Timmo Verlaan"],
      links: %{"GitHub" => @url}
    }
  end
end
