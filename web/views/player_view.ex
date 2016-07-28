defmodule LeaderboardGolf.PlayerView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{players: players}) do
    %{data: render_many(players, LeaderboardGolf.PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, LeaderboardGolf.PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      round_id: player.round_id,
      user_id: player.user_id}
  end
end
