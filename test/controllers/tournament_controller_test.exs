defmodule LeaderboardGolf.TournamentControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Tournament
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tournament_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = get conn, tournament_path(conn, :show, tournament)
    assert json_response(conn, 200)["data"] == %{"id" => tournament.id,
      "name" => tournament.name,
      "description" => tournament.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, tournament_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, tournament_path(conn, :create), tournament: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Tournament, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tournament_path(conn, :create), tournament: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = put conn, tournament_path(conn, :update, tournament), tournament: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Tournament, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = put conn, tournament_path(conn, :update, tournament), tournament: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = delete conn, tournament_path(conn, :delete, tournament)
    assert response(conn, 204)
    refute Repo.get(Tournament, tournament.id)
  end
end
