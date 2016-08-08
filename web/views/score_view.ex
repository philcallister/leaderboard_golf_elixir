defmodule LeaderboardGolf.ScoreView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{scores: scores}) do
    %{data: render_many(scores, LeaderboardGolf.ScoreView, "score.json")}
  end

  def render("show.json", %{score: score}) do
    %{data: render_one(score, LeaderboardGolf.ScoreView, "score.json")}
  end

  def render("score.json", %{score: score}) do
    %{id: score.id,
      card_id: score.card_id,
      hole_id: score.hole_id}
  end
end
