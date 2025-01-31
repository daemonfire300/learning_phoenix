defmodule Gamenect.GameJSONControllerTest do
  use Gamenect.ConnCase

  alias Gamenect.GameJSON
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, game_json_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    game_json = Repo.insert! %GameJSON{}
    conn = get conn, game_json_path(conn, :show, game_json)
    assert json_response(conn, 200)["data"] == %{"id" => game_json.id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, game_json_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, game_json_path(conn, :create), game_json: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(GameJSON, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, game_json_path(conn, :create), game_json: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    game_json = Repo.insert! %GameJSON{}
    conn = put conn, game_json_path(conn, :update, game_json), game_json: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(GameJSON, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    game_json = Repo.insert! %GameJSON{}
    conn = put conn, game_json_path(conn, :update, game_json), game_json: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    game_json = Repo.insert! %GameJSON{}
    conn = delete conn, game_json_path(conn, :delete, game_json)
    assert response(conn, 204)
    refute Repo.get(GameJSON, game_json.id)
  end
end
