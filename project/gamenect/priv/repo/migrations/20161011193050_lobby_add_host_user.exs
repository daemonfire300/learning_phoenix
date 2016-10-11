defmodule Gamenect.Repo.Migrations.LobbyAddHostUser do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      add :host_id, references(:users, [on_delete: :nilify_all])
    end
  end
end
