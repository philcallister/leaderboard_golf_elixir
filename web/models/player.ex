defmodule LeaderboardGolf.Player do
  use LeaderboardGolf.Web, :model

  schema "players" do
    belongs_to :user, LeaderboardGolf.User
    belongs_to :tournament, LeaderboardGolf.Tournament

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :tournament_id])
    |> validate_required([:user_id, :tournament_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:tournament)
  end
end
