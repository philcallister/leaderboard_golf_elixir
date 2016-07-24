defmodule LeaderboardGolf.RoundTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Round

  @valid_attrs %{number: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Round.changeset(%Round{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Round.changeset(%Round{}, @invalid_attrs)
    refute changeset.valid?
  end
end
