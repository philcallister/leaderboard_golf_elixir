defmodule LeaderboardGolf.Card do
  use LeaderboardGolf.Web, :model

  schema "cards" do
    belongs_to :round, LeaderboardGolf.Round
    belongs_to :player, LeaderboardGolf.Player

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:round_id, :player_id])
    |> validate_required([:round_id, :player_id])
    |> assoc_constraint(:round)
    |> assoc_constraint(:player)
  end
end
