defmodule Gamenect.Repo.Migrations.RemoveLobbyCreatedAt do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      remove :created_at
    end
  end
end
