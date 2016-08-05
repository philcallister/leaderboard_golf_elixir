defmodule LeaderboardGolf.CardTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Card
  alias LeaderboardGolf.Round
  alias LeaderboardGolf.Player

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    round = Repo.insert! %Round{}
    player = Repo.insert! %Player{}
    card = Map.merge(@valid_attrs, %{:round_id => round.id, :player_id => player.id})
    changeset = Card.changeset(%Card{}, card)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Card.changeset(%Card{}, @invalid_attrs)
    refute changeset.valid?
  end
end
