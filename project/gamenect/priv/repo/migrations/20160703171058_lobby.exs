defmodule Gamenect.Repo.Migrations.Lobby do
  use Ecto.Migration

  def change do
    alter table(:lobbies) do
      add :max_players, :integer
    end 
  end
end
