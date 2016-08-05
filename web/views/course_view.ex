defmodule LeaderboardGolf.CourseView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{courses: courses}) do
    %{data: render_many(courses, LeaderboardGolf.CourseView, "course.json")}
  end

  def render("show.json", %{course: course}) do
    %{data: render_one(course, LeaderboardGolf.CourseView, "course.json")}
  end

  def render("course.json", %{course: course}) do
    %{id: course.id,
      tournament_id: course.tournament_id}
  end
end
