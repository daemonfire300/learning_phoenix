defmodule Gamenect.LobbyController do
  use Gamenect.Web, :controller

  alias Gamenect.Lobby

  plug :scrub_params, "lobby" when action in [:create, :update]

  def join(conn, %{"id" => id}) do
    case Repo.get(Lobby, id) do
      nil ->
        conn
        |> put_flash(:error, "Lobby does not exist")
        |> redirect(to: lobby_path(conn, :index))
      lobby = %Lobby{} ->
        render(conn, "show.html", lobby: lobby)
    end
  end

  def index(conn, params) do
    query = from p in Lobby
    lobbies = Lobby.ordered_by(query, Map.get(params, "order_by"), Map.get(params, "order", :none)) |> Repo.all
    render(conn, "index.html", lobbies: lobbies)
  end

  def new(conn, _params) do
    changeset = Lobby.changeset(%Lobby{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lobby" => lobby_params}) do
    #%{"game_id" => game_id} = lobby_params
    IO.inspect lobby_params
    #lobby_params = Map.merge(lobby_params, %{"game" => game_id})
    #IO.inspect lobby_params
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
    lobby = Repo.get!(Lobby, id)
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
