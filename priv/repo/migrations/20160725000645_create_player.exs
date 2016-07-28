defmodule LeaderboardGolf.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :round_id, references(:rounds, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:players, [:round_id])
    create index(:players, [:user_id])

  end
end
