defmodule LeaderboardGolf.CourseTest do
  use LeaderboardGolf.ModelCase

  alias LeaderboardGolf.Course
  alias LeaderboardGolf.Tournament

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do

    tournament = Repo.insert! %Tournament{}
    course = Map.merge(@valid_attrs, %{:tournament_id => tournament.id})
    changeset = Course.changeset(%Course{}, course)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Course.changeset(%Course{}, @invalid_attrs)
    refute changeset.valid?
  end
end
