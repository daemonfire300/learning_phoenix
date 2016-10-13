defmodule Gamenect.RegistrationConfirmationTest do
  use Gamenect.ModelCase

  alias Gamenect.RegistrationConfirmation

  @valid_attrs %{token: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = RegistrationConfirmation.changeset(%RegistrationConfirmation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = RegistrationConfirmation.changeset(%RegistrationConfirmation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
