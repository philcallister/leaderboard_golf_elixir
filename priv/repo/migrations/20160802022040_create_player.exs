defmodule LeaderboardGolf.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :tournament_id, references(:tournaments, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:players, [:tournament_id])
    create index(:players, [:user_id])

  end
end
