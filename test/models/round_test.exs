defmodule LeaderboardGolf.RoundTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Round
  alias LeaderboardGolf.Tournament

  @valid_attrs %{number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    tournament = Repo.insert! %Tournament{}
    round = Map.merge(@valid_attrs, %{:tournament_id => tournament.id})

    changeset = Round.changeset(%Round{}, round)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Round.changeset(%Round{}, @invalid_attrs)
    refute changeset.valid?
  end
end
