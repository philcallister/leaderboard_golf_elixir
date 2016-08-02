defmodule LeaderboardGolf.PlayerTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Player
  alias LeaderboardGolf.User
  alias LeaderboardGolf.Tournament

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do

    tournament = Repo.insert! %Tournament{}
    user = Repo.insert! %User{}
    player = Map.merge(@valid_attrs, %{:tournament_id => tournament.id, :user_id => user.id})
    changeset = Player.changeset(%Player{}, player)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Player.changeset(%Player{}, @invalid_attrs)
    refute changeset.valid?
  end
end
