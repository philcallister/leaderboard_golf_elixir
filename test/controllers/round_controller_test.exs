defmodule LeaderboardGolf.RoundControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Round
  alias LeaderboardGolf.Tournament
  @valid_attrs %{number: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries for tournament", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = get conn, tournament_round_path(conn, :index, tournament)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    round = Repo.insert! %Round{}
    conn = get conn, round_path(conn, :show, round)
    assert json_response(conn, 200)["data"] == %{"id" => round.id,
      "tournament_id" => round.tournament_id,
      "number" => round.number}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, round_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    round = Map.merge(@valid_attrs, %{:tournament_id => tournament.id})
    conn = post conn, round_path(conn, :create), round: round
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Round, round)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, round_path(conn, :create), round: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    round = Repo.insert! %Round{:tournament_id => tournament.id}
    conn = put conn, round_path(conn, :update, round), round: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Round, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    round = Repo.insert! %Round{}
    conn = put conn, round_path(conn, :update, round), round: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    round = Repo.insert! %Round{}
    conn = delete conn, round_path(conn, :delete, round)
    assert response(conn, 204)
    refute Repo.get(Round, round.id)
  end
end
