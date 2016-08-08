defmodule LeaderboardGolf.HoleController do
  use LeaderboardGolf.Web, :controller

  alias LeaderboardGolf.Hole

  def index(conn, %{"course_id" => course_id}) do
    holes = Repo.all(from h in Hole, where: h.course_id == ^course_id)
    render(conn, "index.json", holes: holes)
  end

  def create(conn, %{"hole" => hole_params}) do
    changeset = Hole.changeset(%Hole{}, hole_params)

    case Repo.insert(changeset) do
      {:ok, hole} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", hole_path(conn, :show, hole))
        |> render("show.json", hole: hole)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hole = Repo.get!(Hole, id)
    render(conn, "show.json", hole: hole)
  end

  def update(conn, %{"id" => id, "hole" => hole_params}) do
    hole = Repo.get!(Hole, id)
    changeset = Hole.changeset(hole, hole_params)

    case Repo.update(changeset) do
      {:ok, hole} ->
        render(conn, "show.json", hole: hole)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hole = Repo.get!(Hole, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hole)

    send_resp(conn, :no_content, "")
  end
end
