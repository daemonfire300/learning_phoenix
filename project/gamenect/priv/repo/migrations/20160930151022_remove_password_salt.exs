defmodule Gamenect.Repo.Migrations.RemovePasswordSalt do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :salt
    end
  end
end
