defmodule LeaderboardGolf.CourseControllerTest do
  use LeaderboardGolf.ConnCase

  alias LeaderboardGolf.Course
  alias LeaderboardGolf.Tournament

  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    conn = get conn, tournament_course_path(conn, :index, tournament)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    course = Repo.insert! %Course{}
    conn = get conn, course_path(conn, :show, course)
    assert json_response(conn, 200)["data"] == %{"id" => course.id,
      "tournament_id" => course.tournament_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, course_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    course = Map.merge(@valid_attrs, %{:tournament_id => tournament.id})
    conn = post conn, course_path(conn, :create), course: course
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Course, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, course_path(conn, :create), course: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    tournament = Repo.insert! %Tournament{}
    course = Repo.insert! %Course{:tournament_id => tournament.id}
    conn = put conn, course_path(conn, :update, course), course: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Course, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    course = Repo.insert! %Course{}
    conn = put conn, course_path(conn, :update, course), course: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    course = Repo.insert! %Course{}
    conn = delete conn, course_path(conn, :delete, course)
    assert response(conn, 204)
    refute Repo.get(Course, course.id)
  end
end
