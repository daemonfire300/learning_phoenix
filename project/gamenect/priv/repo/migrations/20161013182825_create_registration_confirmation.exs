defmodule Gamenect.Repo.Migrations.CreateRegistrationConfirmation do
  use Ecto.Migration

  def change do
    create table(:confirmations) do
      add :token, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:confirmations, [:user_id])

  end
end
