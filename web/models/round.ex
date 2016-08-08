defmodule LeaderboardGolf.Round do
  use LeaderboardGolf.Web, :model

  schema "rounds" do
    field :number, :integer

    belongs_to :tournament, LeaderboardGolf.Tournament
    has_many :cards, LeaderboardGolf.Card

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:number, :tournament_id])
    |> validate_required([:number, :tournament_id])
    |> assoc_constraint(:tournament)
  end
end
