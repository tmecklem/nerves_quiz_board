defmodule NervesQuizBoard.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi"

  def project do
    [app: :nerves_quiz_board,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "0.1.2"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  def application do
    [mod: {NervesQuizBoard, []},
     applications: [:nerves, :logger, :quiz_board]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:quiz_board, github: "tmecklem/quiz_board"}]
  end

  def system("rpi") do
    [{:nerves_system_rpi, github: "nerves-project/nerves_system_rpi", branch: "stable"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
end
