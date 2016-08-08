defmodule LeaderboardGolf.ScoreControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Score
  alias LeaderboardGolf.Card
  alias LeaderboardGolf.Hole

  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = get conn, card_score_path(conn, :index, card)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = get conn, score_path(conn, :show, score)
    assert json_response(conn, 200)["data"] == %{"id" => score.id,
      "card_id" => score.card_id,
      "hole_id" => score.hole_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, score_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    card = Repo.insert! %Card{}
    hole = Repo.insert! %Hole{}
    score = Map.merge(@valid_attrs, %{:card_id => card.id, :hole_id => hole.id})
    conn = post conn, score_path(conn, :create), score: score
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Score, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, score_path(conn, :create), score: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    card = Repo.insert! %Card{}
    hole = Repo.insert! %Hole{}
    score = Repo.insert! %Score{:card_id => card.id, :hole_id => hole.id}
    conn = put conn, score_path(conn, :update, score), score: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Score, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = put conn, score_path(conn, :update, score), score: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    score = Repo.insert! %Score{}
    conn = delete conn, score_path(conn, :delete, score)
    assert response(conn, 204)
    refute Repo.get(Score, score.id)
  end
end
