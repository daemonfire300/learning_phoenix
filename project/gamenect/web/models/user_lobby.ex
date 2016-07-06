defmodule Gamenect.UserLobby do
  use Gamenect.Web, :model

  schema "user_lobby" do
    field :joined_at, Ecto.DateTime
    field :left_at, Ecto.DateTime
    belongs_to :user, Gamenect.User
    belongs_to :lobby, Gamenect.Lobby

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:joined_at, :left_at])
    |> validate_required([:joined_at, :left_at])
  end
end
