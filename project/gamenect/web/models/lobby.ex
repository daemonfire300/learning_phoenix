defmodule Gamenect.Lobby do
  use Gamenect.Web, :model

  schema "lobbies" do
    field :title, :string
    field :finished_at, Ecto.DateTime
    field :status, :integer
    field :password, :string
    field :max_players, :integer
    belongs_to :game, Gamenect.Game
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :finished_at, :status, :password, :max_players])
    |> validate_required([:title])
    |> validate_inclusion(:max_players, 1..255)
  end

  def create_changeset(struct, params \\ %{}) do
    struct 
    |> cast(params, [:title, :password, :max_players, :game_id])
    |> assoc_constraint(:game)
    |> validate_required([:title, :game_id])
    |> validate_inclusion(:max_players, 1..255)
  end

  def ordered_by(query, nil, _order) do
    query
  end

  @doc """
  `ordered_by/3` handles the creation of the `Ecto.Query` part that is responsible for sorting.
  It is a convience function that uses `field` and `order` to build an `Ecto.Query` for sorting by
  `field` with order type `order(ASC|DESC)`.
  This involves casting strings to atoms, as this function is expected to be used in a controller,
  thus the received variables are strings from the phoenix/plug `conn` (`Plug.Conn`) `params`.

  iex> ordered_by(:query, "title", "asc")
  from p in query, order_by: [asc: ^field]
  """
  def ordered_by(query, field, order) when is_bitstring field do
    case order do
      order when is_atom(order) -> 
        ordered_by query, String.to_atom(field), order
      _ ->
        ordered_by query, String.to_atom(field), String.to_atom(order)
    end
  end

  def ordered_by(query, field, order) when is_atom field do
      case order do
        :none ->
          ordered_by_desc query, field
        :desc ->
          ordered_by_desc query, field
        :asc ->
          ordered_by_asc query, field
        _ ->
          ordered_by_desc query, field
      end
  end

  def ordered_by_desc(query, field) when is_atom field do
      from p in query,
      order_by: [desc: ^field]
  end

  def ordered_by_asc(query, field) when is_atom field do
      from p in query,
      order_by: [asc: ^field]
  end

  def open?(query) do
    status query, :open
  end

  def status(query, status) do
    case status do
      :open -> 
        from p in query,
        where: p.status == 1
      :closed -> 
        from p in query,
        where: p.status == 0
      :finished -> 
        from p in query,
        where: p.status == 2
      _ ->
        query
    end
  end

end
