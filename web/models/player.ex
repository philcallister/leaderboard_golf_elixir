defmodule LeaderboardGolf.Player do
  use LeaderboardGolf.Web, :model

  schema "players" do
    belongs_to :round, LeaderboardGolf.Round
    belongs_to :user, LeaderboardGolf.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:round_id, :user_id])
    |> validate_required([:round_id, :user_id])
    |> assoc_constraint(:round)
    |> assoc_constraint(:user)

  end
end
