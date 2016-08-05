defmodule LeaderboardGolf.CourseController do
  use LeaderboardGolf.Web, :controller

  alias LeaderboardGolf.Course

  def index(conn, %{"tournament_id" => tournament_id}) do
    courses = Repo.all(from c in Course, where: c.tournament_id == ^tournament_id)
    render(conn, "index.json", courses: courses)
  end

  def create(conn, %{"course" => course_params}) do
    changeset = Course.changeset(%Course{}, course_params)

    case Repo.insert(changeset) do
      {:ok, course} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", course_path(conn, :show, course))
        |> render("show.json", course: course)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    course = Repo.get!(Course, id)
    render(conn, "show.json", course: course)
  end

  def update(conn, %{"id" => id, "course" => course_params}) do
    course = Repo.get!(Course, id)
    changeset = Course.changeset(course, course_params)

    case Repo.update(changeset) do
      {:ok, course} ->
        render(conn, "show.json", course: course)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    course = Repo.get!(Course, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(course)

    send_resp(conn, :no_content, "")
  end
end
