defmodule Gamenect.UserLobbyController do
  use Gamenect.Web, :controller

  alias Gamenect.UserLobby

  def index(conn, _params) do
    user_lobby = Repo.all(UserLobby)
    render(conn, "index.html", user_lobby: user_lobby)
  end

  def new(conn, _params) do
    changeset = UserLobby.changeset(%UserLobby{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_lobby" => user_lobby_params}) do
    changeset = UserLobby.changeset(%UserLobby{}, user_lobby_params)

    case Repo.insert(changeset) do
      {:ok, _user_lobby} ->
        conn
        |> put_flash(:info, "User lobby created successfully.")
        |> redirect(to: user_lobby_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_lobby = Repo.get!(UserLobby, id)
    render(conn, "show.html", user_lobby: user_lobby)
  end

  def edit(conn, %{"id" => id}) do
    user_lobby = Repo.get!(UserLobby, id)
    changeset = UserLobby.changeset(user_lobby)
    render(conn, "edit.html", user_lobby: user_lobby, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_lobby" => user_lobby_params}) do
    user_lobby = Repo.get!(UserLobby, id)
    changeset = UserLobby.changeset(user_lobby, user_lobby_params)

    case Repo.update(changeset) do
      {:ok, user_lobby} ->
        conn
        |> put_flash(:info, "User lobby updated successfully.")
        |> redirect(to: user_lobby_path(conn, :show, user_lobby))
      {:error, changeset} ->
        render(conn, "edit.html", user_lobby: user_lobby, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_lobby = Repo.get!(UserLobby, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_lobby)

    conn
    |> put_flash(:info, "User lobby deleted successfully.")
    |> redirect(to: user_lobby_path(conn, :index))
  end
end
