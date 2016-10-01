defmodule Gamenect.GameJSONTest do
  use Gamenect.ModelCase

  alias Gamenect.GameJSON

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GameJSON.changeset(%GameJSON{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GameJSON.changeset(%GameJSON{}, @invalid_attrs)
    refute changeset.valid?
  end
end
