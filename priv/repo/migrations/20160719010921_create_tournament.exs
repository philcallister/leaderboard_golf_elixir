defmodule LeaderboardGolf.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
