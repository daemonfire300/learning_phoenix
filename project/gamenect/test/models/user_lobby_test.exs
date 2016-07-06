defmodule Gamenect.UserLobbyTest do
  use Gamenect.ModelCase

  alias Gamenect.UserLobby

  @valid_attrs %{joined_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, left_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserLobby.changeset(%UserLobby{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserLobby.changeset(%UserLobby{}, @invalid_attrs)
    refute changeset.valid?
  end
end
