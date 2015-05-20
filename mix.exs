defmodule Reddhl.Mixfile do
  use Mix.Project

  def project do
    [app: :reddhl,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: description,
     source_url: "https://github.com/MonkeyIsNull/reddhl"
     package: package ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    An headline and link puller for Reddit and its various subreddits
    """
  end

  
  defp package do
      [# These are the default files included in the package
       files: ["lib", "files", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "*LICENSE"],
       contributors: ["Adam Guyot"],
       licenses: ["Apache 2.0"],
       links: %{"GitHub" => "https://github.com/MonkeyIsNull/reddhl"}]
  end

  defp deps do
    [{:httpoison, "~> 0.6"},
     {:poison, "~> 1.4.0"}]
  end
end
