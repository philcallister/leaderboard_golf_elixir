defmodule LeaderboardGolf.Hole do
  use LeaderboardGolf.Web, :model

  schema "holes" do
    belongs_to :course, LeaderboardGolf.Course

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:course_id])
    |> validate_required([:course_id])
    |> assoc_constraint(:course)
  end
end
