defmodule LeaderboardGolf.HoleTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Hole
  alias LeaderboardGolf.Course

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    course = Repo.insert! %Course{}
    hole = Map.merge(@valid_attrs, %{:course_id => course.id})
    changeset = Hole.changeset(%Hole{}, hole)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Hole.changeset(%Hole{}, @invalid_attrs)
    refute changeset.valid?
  end
end
