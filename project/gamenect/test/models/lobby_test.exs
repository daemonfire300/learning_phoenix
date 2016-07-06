defmodule Gamenect.LobbyTest do
  use Gamenect.ModelCase

  alias Gamenect.Lobby

  @valid_attrs %{created_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, finished_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, password: "some content", status: 42, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Lobby.changeset(%Lobby{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Lobby.changeset(%Lobby{}, @invalid_attrs)
    refute changeset.valid?
  end
end
