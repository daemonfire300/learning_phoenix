defmodule Gamenect.Repo.Migrations.AddLobbyGameRelation do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      add :game, references(:games, [on_delete: :nilify_all])
    end
  end
end
