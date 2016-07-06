defmodule Gamenect.UserLobbyControllerTest do
  use Gamenect.ConnCase

  alias Gamenect.UserLobby
  @valid_attrs %{joined_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, left_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_lobby_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user lobby"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_lobby_path(conn, :new)
    assert html_response(conn, 200) =~ "New user lobby"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_lobby_path(conn, :create), user_lobby: @valid_attrs
    assert redirected_to(conn) == user_lobby_path(conn, :index)
    assert Repo.get_by(UserLobby, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_lobby_path(conn, :create), user_lobby: @invalid_attrs
    assert html_response(conn, 200) =~ "New user lobby"
  end

  test "shows chosen resource", %{conn: conn} do
    user_lobby = Repo.insert! %UserLobby{}
    conn = get conn, user_lobby_path(conn, :show, user_lobby)
    assert html_response(conn, 200) =~ "Show user lobby"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_lobby_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_lobby = Repo.insert! %UserLobby{}
    conn = get conn, user_lobby_path(conn, :edit, user_lobby)
    assert html_response(conn, 200) =~ "Edit user lobby"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_lobby = Repo.insert! %UserLobby{}
    conn = put conn, user_lobby_path(conn, :update, user_lobby), user_lobby: @valid_attrs
    assert redirected_to(conn) == user_lobby_path(conn, :show, user_lobby)
    assert Repo.get_by(UserLobby, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_lobby = Repo.insert! %UserLobby{}
    conn = put conn, user_lobby_path(conn, :update, user_lobby), user_lobby: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user lobby"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_lobby = Repo.insert! %UserLobby{}
    conn = delete conn, user_lobby_path(conn, :delete, user_lobby)
    assert redirected_to(conn) == user_lobby_path(conn, :index)
    refute Repo.get(UserLobby, user_lobby.id)
  end
end
