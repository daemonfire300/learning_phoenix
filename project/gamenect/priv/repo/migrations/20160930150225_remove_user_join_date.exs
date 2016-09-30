defmodule Gamenect.Repo.Migrations.RemoveUserJoinDate do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :joindate
    end
  end
end
