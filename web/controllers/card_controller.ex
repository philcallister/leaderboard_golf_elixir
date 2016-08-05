defmodule LeaderboardGolf.CardController do
  use LeaderboardGolf.Web, :controller

  alias LeaderboardGolf.Card

  def index(conn, %{"round_id" => round_id}) do
    cards = Repo.all(from c in Card, where: c.round_id == ^round_id)
    render(conn, "index.json", cards: cards)
  end

  def index(conn, %{"player_id" => player_id}) do
    cards = Repo.all(from c in Card, where: c.player_id == ^player_id)
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    changeset = Card.changeset(%Card{}, card_params)

    case Repo.insert(changeset) do
      {:ok, card} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", card_path(conn, :show, card))
        |> render("show.json", card: card)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Repo.get!(Card, id)
    changeset = Card.changeset(card, card_params)

    case Repo.update(changeset) do
      {:ok, card} ->
        render(conn, "show.json", card: card)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LeaderboardGolf.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(card)

    send_resp(conn, :no_content, "")
  end
end
