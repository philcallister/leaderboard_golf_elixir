defmodule LeaderboardGolf.TournamentView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{tournaments: tournaments}) do
    %{data: render_many(tournaments, LeaderboardGolf.TournamentView, "tournament.json")}
  end

  def render("show.json", %{tournament: tournament}) do
    %{data: render_one(tournament, LeaderboardGolf.TournamentView, "tournament.json")}
  end

  def render("tournament.json", %{tournament: tournament}) do
    %{id: tournament.id,
      name: tournament.name,
      description: tournament.description}
  end
end
