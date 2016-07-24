defmodule LeaderboardGolf.UserView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, LeaderboardGolf.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, LeaderboardGolf.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      name: user.name}
  end
end
