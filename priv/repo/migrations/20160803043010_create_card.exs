defmodule LeaderboardGolf.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :round_id, references(:rounds, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps()
    end
    create index(:cards, [:round_id])
    create index(:cards, [:player_id])

  end
end
