defmodule Gamenect.Repo.Migrations.CreateLobby do
  use Ecto.Migration

  def change do
    create table(:lobbies) do
      add :title, :string
      add :created_at, :datetime
      add :finished_at, :datetime
      add :status, :integer
      add :password, :string

      timestamps()
    end

  end
end
