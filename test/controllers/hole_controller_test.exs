defmodule LeaderboardGolf.HoleControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Hole
  alias LeaderboardGolf.Course

  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    course = Repo.insert! %Course{}
    conn = get conn, course_hole_path(conn, :index, course)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    hole = Repo.insert! %Hole{}
    conn = get conn, hole_path(conn, :show, hole)
    assert json_response(conn, 200)["data"] == %{"id" => hole.id,
      "course_id" => hole.course_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, hole_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    course = Repo.insert! %Course{}
    hole = Map.merge(@valid_attrs, %{:course_id => course.id})
    conn = post conn, hole_path(conn, :create), hole: hole
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Hole, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hole_path(conn, :create), hole: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    course = Repo.insert! %Course{}
    hole = Repo.insert! %Hole{:course_id => course.id}
    conn = put conn, hole_path(conn, :update, hole), hole: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Hole, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hole = Repo.insert! %Hole{}
    conn = put conn, hole_path(conn, :update, hole), hole: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    hole = Repo.insert! %Hole{}
    conn = delete conn, hole_path(conn, :delete, hole)
    assert response(conn, 204)
    refute Repo.get(Hole, hole.id)
  end
end
