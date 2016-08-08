defmodule LeaderboardGolf.Repo.Migrations.CreateHole do
  use Ecto.Migration

  def change do
    create table(:holes) do
      add :course_id, references(:courses, on_delete: :nothing)

      timestamps()
    end
    create index(:holes, [:course_id])

  end
end
