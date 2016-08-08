defmodule LeaderboardGolf.Repo.Migrations.CreateScore do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :card_id, references(:cards, on_delete: :nothing)
      add :hole_id, references(:holes, on_delete: :nothing)

      timestamps()
    end
    create index(:scores, [:card_id])
    create index(:scores, [:hole_id])

  end
end
