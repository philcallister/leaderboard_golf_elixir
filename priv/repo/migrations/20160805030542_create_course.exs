defmodule LeaderboardGolf.Repo.Migrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :tournament_id, references(:tournaments, on_delete: :nothing)

      timestamps()
    end
    create index(:courses, [:tournament_id])

  end
end
