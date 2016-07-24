defmodule LeaderboardGolf.User do
  use LeaderboardGolf.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name])
    |> validate_required([:email, :name])
  end
end
