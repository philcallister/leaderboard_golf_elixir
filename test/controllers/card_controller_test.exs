defmodule LeaderboardGolf.CardControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Card
  alias LeaderboardGolf.Player
  alias LeaderboardGolf.Round

  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index (player)", %{conn: conn} do
    player = Repo.insert! %Player{}
    conn = get conn, player_card_path(conn, :index, player)
    assert json_response(conn, 200)["data"] == []
  end

  test "lists all entries on index (round)", %{conn: conn} do
    round = Repo.insert! %Round{}
    conn = get conn, round_card_path(conn, :index, round)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = get conn, card_path(conn, :show, card)
    assert json_response(conn, 200)["data"] == %{"id" => card.id,
      "round_id" => card.round_id,
      "player_id" => card.player_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, card_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    round = Repo.insert! %Round{}
    player = Repo.insert! %Player{}
    card = Map.merge(@valid_attrs, %{:round_id => round.id, :player_id => player.id})
    conn = post conn, card_path(conn, :create), card: card
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, card_path(conn, :create), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    round = Repo.insert! %Round{}
    player = Repo.insert! %Player{}
    card = Repo.insert! %Card{:round_id => round.id, :player_id => player.id}
    conn = put conn, card_path(conn, :update, card), card: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Card, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = put conn, card_path(conn, :update, card), card: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    card = Repo.insert! %Card{}
    conn = delete conn, card_path(conn, :delete, card)
    assert response(conn, 204)
    refute Repo.get(Card, card.id)
  end
end
