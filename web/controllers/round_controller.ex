defmodule LeaderboardGolf.RoundController do
  use LeaderboardGolf.Web, :controller

  alias LeaderboardGolf.Round

  def index(conn, %{"tournament_id" => tournament_id}) do
    rounds = Repo.all(from r in Round, where: r.tournament_id == ^tournament_id)
    render(conn, "index.json", rounds: rounds)
  end

  def create(conn, %{"round" => round_params}) do
    changeset = Round.changeset(%Round{}, round_params)

    case Repo.insert(changeset) do
      {:ok, round} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", round_path(conn, :show, round))
        |> render("show.json", round: round)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    round = Repo.get!(Round, id)
    render(conn, "show.json", round: round)
  end

  def update(conn, %{"id" => id, "round" => round_params}) do
    round = Repo.get!(Round, id)
    changeset = Round.changeset(round, round_params)

    case Repo.update(changeset) do
      {:ok, round} ->
        render(conn, "show.json", round: round)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    round = Repo.get!(Round, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(round)

    send_resp(conn, :no_content, "")
  end
end
