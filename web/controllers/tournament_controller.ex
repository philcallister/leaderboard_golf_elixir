defmodule LeaderboardGolf.TournamentController do
  use LeaderboardGolf.Web, :controller

  alias LeaderboardGolf.Tournament

  def index(conn, _params) do
    tournaments = Repo.all(Tournament)
    render(conn, "index.json", tournaments: tournaments)
  end

  def create(conn, %{"tournament" => tournament_params}) do
    changeset = Tournament.changeset(%Tournament{}, tournament_params)

    case Repo.insert(changeset) do
      {:ok, tournament} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", tournament_path(conn, :show, tournament))
        |> render("show.json", tournament: tournament)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id)
    render(conn, "show.json", tournament: tournament)
  end

  def update(conn, %{"id" => id, "tournament" => tournament_params}) do
    tournament = Repo.get!(Tournament, id)
    changeset = Tournament.changeset(tournament, tournament_params)

    case Repo.update(changeset) do
      {:ok, tournament} ->
        render(conn, "show.json", tournament: tournament)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tournament)

    send_resp(conn, :no_content, "")
  end

  def rounds(conn, %{"id" => id}) do
    tournament = Repo.get!(Tournament, id) |> Repo.preload([:rounds])

    IO.puts "!!!!! #{inspect(tournament)} | #{inspect(tournament.rounds)}"

    render(conn, "rounds.json", tournament: tournament)
  end

end
