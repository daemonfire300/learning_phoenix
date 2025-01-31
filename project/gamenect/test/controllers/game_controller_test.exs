defmodule Gamenect.GameControllerTest do
  use Gamenect.ConnCase

  alias Gamenect.Game
  @valid_attrs %{category: "some content", image: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, game_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing games"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, game_path(conn, :new)
    assert html_response(conn, 200) =~ "New game"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, game_path(conn, :create), game: @valid_attrs
    assert redirected_to(conn) == game_path(conn, :index)
    assert Repo.get_by(Game, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, game_path(conn, :create), game: @invalid_attrs
    assert html_response(conn, 200) =~ "New game"
  end

  test "shows chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = get conn, game_path(conn, :show, game)
    assert html_response(conn, 200) =~ "Show game"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = get conn, game_path(conn, :edit, game)
    assert html_response(conn, 200) =~ "Edit game"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = put conn, game_path(conn, :update, game), game: @valid_attrs
    assert redirected_to(conn) == game_path(conn, :show, game)
    assert Repo.get_by(Game, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = put conn, game_path(conn, :update, game), game: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit game"
  end

  test "deletes chosen resource", %{conn: conn} do
    game = Repo.insert! %Game{}
    conn = delete conn, game_path(conn, :delete, game)
    assert redirected_to(conn) == game_path(conn, :index)
    refute Repo.get(Game, game.id)
  end
end
