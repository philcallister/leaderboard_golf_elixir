defmodule LeaderboardGolf.Tournament do
  use LeaderboardGolf.Web, :model

  schema "tournaments" do
    field :name, :string
    field :description, :string
    has_many :rounds, LeaderboardGolf.Tournament    

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name, :description])
  end
end
