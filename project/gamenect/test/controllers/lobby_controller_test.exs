defmodule Gamenect.LobbyControllerTest do
  use Gamenect.ConnCase

  alias Gamenect.Lobby
  @valid_attrs %{created_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, finished_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, password: "some content", status: 42, title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lobby_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing lobbies"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, lobby_path(conn, :new)
    assert html_response(conn, 200) =~ "New lobby"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, lobby_path(conn, :create), lobby: @valid_attrs
    assert redirected_to(conn) == lobby_path(conn, :index)
    assert Repo.get_by(Lobby, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lobby_path(conn, :create), lobby: @invalid_attrs
    assert html_response(conn, 200) =~ "New lobby"
  end

  test "shows chosen resource", %{conn: conn} do
    lobby = Repo.insert! %Lobby{}
    conn = get conn, lobby_path(conn, :show, lobby)
    assert html_response(conn, 200) =~ "Show lobby"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, lobby_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    lobby = Repo.insert! %Lobby{}
    conn = get conn, lobby_path(conn, :edit, lobby)
    assert html_response(conn, 200) =~ "Edit lobby"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    lobby = Repo.insert! %Lobby{}
    conn = put conn, lobby_path(conn, :update, lobby), lobby: @valid_attrs
    assert redirected_to(conn) == lobby_path(conn, :show, lobby)
    assert Repo.get_by(Lobby, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    lobby = Repo.insert! %Lobby{}
    conn = put conn, lobby_path(conn, :update, lobby), lobby: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit lobby"
  end

  test "deletes chosen resource", %{conn: conn} do
    lobby = Repo.insert! %Lobby{}
    conn = delete conn, lobby_path(conn, :delete, lobby)
    assert redirected_to(conn) == lobby_path(conn, :index)
    refute Repo.get(Lobby, lobby.id)
  end
end
