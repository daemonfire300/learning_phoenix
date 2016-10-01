defmodule Gamenect.Repo.Migrations.ChangeGameLobbyRelationFieldName do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      remove :game
      add :game_id, references(:games, [on_delete: :nilify_all])
    end
  end
end
