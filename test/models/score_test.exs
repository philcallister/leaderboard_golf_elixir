defmodule LeaderboardGolf.ScoreTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Score
  alias LeaderboardGolf.Card
  alias LeaderboardGolf.Hole

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    card = Repo.insert! %Card{}
    hole = Repo.insert! %Hole{}
    score = Map.merge(@valid_attrs, %{:card_id => card.id, :hole_id => hole.id})
    changeset = Score.changeset(%Score{}, score)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Score.changeset(%Score{}, @invalid_attrs)
    refute changeset.valid?
  end
end
