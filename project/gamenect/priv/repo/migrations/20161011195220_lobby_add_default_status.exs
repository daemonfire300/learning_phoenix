defmodule Gamenect.Repo.Migrations.LobbyAddDefaultStatus do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      modify :status, :integer, default: 1
    end
  end
end
