defmodule Gamenect.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :joindate, :datetime
      add :password, :string
      add :salt, :string

      timestamps()
    end

  end
end
