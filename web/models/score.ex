defmodule LeaderboardGolf.Score do
  use LeaderboardGolf.Web, :model

  schema "scores" do
    belongs_to :card, LeaderboardGolf.Card
    belongs_to :hole, LeaderboardGolf.Hole

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:card_id, :hole_id])
    |> validate_required([:card_id, :hole_id])
    |> assoc_constraint(:card)
    |> assoc_constraint(:hole)
  end
end
