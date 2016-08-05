defmodule LeaderboardGolf.CardView do
  use LeaderboardGolf.Web, :view

  def render("index.json", %{cards: cards}) do
    %{data: render_many(cards, LeaderboardGolf.CardView, "card.json")}
  end

  def render("show.json", %{card: card}) do
    %{data: render_one(card, LeaderboardGolf.CardView, "card.json")}
  end

  def render("card.json", %{card: card}) do
    %{id: card.id,
      round_id: card.round_id,
      player_id: card.player_id}
  end
end
