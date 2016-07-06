defmodule Gamenect.Repo.Migrations.CreateUserLobby do
  use Ecto.Migration

  def change do
    create table(:user_lobby) do
      add :joined_at, :datetime
      add :left_at, :datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :lobby_id, references(:lobbies, on_delete: :nothing)

      timestamps()
    end
    create index(:user_lobby, [:user_id])
    create index(:user_lobby, [:lobby_id])

  end
end
