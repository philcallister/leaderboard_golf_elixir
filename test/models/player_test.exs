defmodule LeaderboardGolf.PlayerTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Player
  alias LeaderboardGolf.User
  alias LeaderboardGolf.Round

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    user = Repo.insert! %User{}
    round = Repo.insert! %Round{}
    player = %{:user_id => user.id, :round_id => round.id}

    changeset = Player.changeset(%Player{}, player)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end
