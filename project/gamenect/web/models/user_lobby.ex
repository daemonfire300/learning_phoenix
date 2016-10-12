defmodule Gamenect.UserLobby do
  use Gamenect.Web, :model

  schema "user_lobby" do
    field :joined_at, Ecto.DateTime
    field :left_at, Ecto.DateTime
    belongs_to :user, Gamenect.User
    belongs_to :lobby, Gamenect.Lobby
    field :max_players, :integer, virtual: true
    field :player_count, :integer, virtual: true
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
    |> cast(%{joined_at: DateTime.utc_now()}, [:joined_at])
  end

  def add_join_date(changeset, _params), do: add_join_date(changeset)

  def is_already_in_lobby(changeset, _params \\ %{}) do
    changeset
    |> validate_exclusion(:user_id, get_change(changeset, :players))
  end

  @doc """
  
  """
  def check_if_full(changeset, _params \\ %{}) do
    changeset
    |> validate_number(:player_count, greater_than_or_equal_to: 0, less_than_or_equal_to: get_change(changeset, :max_players))
  end

  def join_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :lobby_id, :max_players, :player_count])
    |> put_change(:players, params["players"])
    |> is_already_in_lobby
    |> assoc_constraint(:user)
    |> assoc_constraint(:lobby)
    |> add_join_date
    |> validate_required([:joined_at, :user_id, :lobby_id, :max_players, :player_count])
    |> check_if_full
  end
end
