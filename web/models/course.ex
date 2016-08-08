defmodule LeaderboardGolf.Course do
  use LeaderboardGolf.Web, :model

  schema "courses" do
    belongs_to :tournament, LeaderboardGolf.Tournament
    has_many :holes, LeaderboardGolf.Hole

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tournament_id])
    |> validate_required([:tournament_id])
    |> assoc_constraint(:tournament)
  end
end
