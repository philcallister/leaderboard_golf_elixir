defmodule LeaderboardGolf.RoundView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{rounds: rounds}) do
    %{data: render_many(rounds, LeaderboardGolf.RoundView, "round.json")}
  end

  def render("show.json", %{round: round}) do
    %{data: render_one(round, LeaderboardGolf.RoundView, "round.json")}
  end

  def render("round.json", %{round: round}) do
    %{id: round.id,
      tournament_id: round.tournament_id,
      number: round.number}
  end
end
