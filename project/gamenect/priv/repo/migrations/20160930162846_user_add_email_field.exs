defmodule Gamenect.Repo.Migrations.UserAddEmailField do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
    end
  end
end
