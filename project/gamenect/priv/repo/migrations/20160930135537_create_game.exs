defmodule Gamenect.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :title, :string
      add :category, :string
      add :image, :string

      timestamps()
    end

  end
end
