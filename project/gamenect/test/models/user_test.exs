defmodule Gamenect.UserTest do
  use Gamenect.ModelCase

  alias Gamenect.User

  @valid_attrs %{joindate: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", password: "some content", salt: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
