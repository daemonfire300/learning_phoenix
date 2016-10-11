defmodule Gamenect.LobbyController do
  use Gamenect.Web, :controller

  alias Gamenect.Lobby
  alias Gamenect.UserLobby

  plug :scrub_params, "lobby" when action in [:create, :update]
  plug Guardian.Plug.EnsureAuthenticated when action in [:join]

  def get_player_count(id) do
    Repo.one!(from u in UserLobby, where: u.lobby_id == ^id, select: count(u.user_id))
  end

  def join(conn, %{"id" => id}) do
    %Gamenect.User{:id => user_id} = Guardian.Plug.current_resource(conn)
    case Repo.get(Lobby, id) do
      nil ->
        conn
        |> put_flash(:error, "Lobby does not exist")
        |> redirect(to: lobby_path(conn, :index))
      lobby = %Lobby{} ->
        player_count = get_player_count(id)
        IO.inspect user_id
        IO.inspect id
        IO.inspect lobby
        IO.inspect player_count
        user_lobby = UserLobby.join_changeset(%UserLobby{
        }, %{
          "user_id" => user_id,
          "lobby_id" => id,
          "lobby" => lobby,
          "max_players" => lobby.max_players || 5,
          "player_count" => player_count
        })
        case Repo.insert(user_lobby) do
          {:ok, _joined} ->
            conn
            |> put_flash(:info, "Joined lobby")
            |> render("show.html", lobby: lobby)
          {:error, err} ->
            conn
            |> put_flash(:error, err)
            |> redirect(to: lobby_path(conn, :index))
        end
    end
  end

  def index(conn, params) do
    query = from p in Lobby
    lobbies = Lobby.ordered_by(query, Map.get(params, "order_by"), Map.get(params, "order", :none)) |> Repo.all |> Repo.preload(:game)
    render(conn, "index.html", lobbies: lobbies)
  end

  def new(conn, _params) do
    changeset = Lobby.changeset(%Lobby{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lobby" => lobby_params}) do
    %Gamenect.User{:id => user_id} = Guardian.Plug.current_resource(conn)
    lobby_params = Map.merge(lobby_params, %{"host_id" => user_id})
    changeset = Lobby.create_changeset(%Lobby{}, lobby_params)
    IO.inspect changeset
    case Repo.insert(changeset) do
      {:ok, _lobby} ->
        conn
        |> put_flash(:info, "Lobby created successfully.")
        |> redirect(to: lobby_path(conn, :index))
      {:error, changeset} ->
        IO.inspect changeset
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lobby = Repo.get!(Lobby, id) |> Repo.preload([:host, :game])
    render(conn, "show.html", lobby: lobby)
  end

  def edit(conn, %{"id" => id}) do
    lobby = Repo.get!(Lobby, id)
    changeset = Lobby.changeset(lobby)
    render(conn, "edit.html", lobby: lobby, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lobby" => lobby_params}) do
    lobby = Repo.get!(Lobby, id)
    changeset = Lobby.changeset(lobby, lobby_params)

    case Repo.update(changeset) do
      {:ok, lobby} ->
        conn
        |> put_flash(:info, "Lobby updated successfully.")
        |> redirect(to: lobby_path(conn, :show, lobby))
      {:error, changeset} ->
        render(conn, "edit.html", lobby: lobby, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lobby = Repo.get!(Lobby, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(lobby)

    conn
    |> put_flash(:info, "Lobby deleted successfully.")
    |> redirect(to: lobby_path(conn, :index))
  end
end
