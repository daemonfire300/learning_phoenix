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

  def add_join_date(changeset) do
    changeset
    |> put_change(:joined_at, DateTime.utc_now())
  end

  def add_join_date(changeset, _params), do: add_join_date(changeset)

  @doc """
  
  """
  def check_if_full(%{"max_players" => max_players} = changeset, _params \\ %{}) do
    changeset
    |> validate_inclusion(:player_count, min: 0, max: max_players)
  end

  def join_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :lobby_id, :max_players, :player_count])
    |> add_join_date
    |> validate_required([:joined_at, :user_id, :lobby_id, :max_players, :player_count])
    |> check_if_full
  end
end
