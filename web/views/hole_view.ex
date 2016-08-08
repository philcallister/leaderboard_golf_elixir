defmodule LeaderboardGolf.HoleView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{holes: holes}) do
    %{data: render_many(holes, LeaderboardGolf.HoleView, "hole.json")}
  end

  def render("show.json", %{hole: hole}) do
    %{data: render_one(hole, LeaderboardGolf.HoleView, "hole.json")}
  end

  def render("hole.json", %{hole: hole}) do
    %{id: hole.id,
      course_id: hole.course_id}
  end
end
