defmodule LeaderboardGolf.Repo.Migrations.CreateRound do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :number, :integer
      add :tournament_id, references(:tournaments, on_delete: :nothing)

      timestamps()
    end
    create index(:rounds, [:tournament_id])

  end
end
