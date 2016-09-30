defmodule Gamenect.User do
  use Gamenect.Web, :model
  alias Comeonin.Bcrypt

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password])
    |> validate_required([:name])
  end

  def create_changeset(struct, params \\ %{}) do
    changeset = cast(struct, params, [:name, :password])
    changeset
    |> validate_required([:name, :password])
    |> validate_length(:password, min: 6, max: 32)
    |> put_change(:password, hash_password(get_field(changeset, :password)))
  end

  def login_changeset(state, struct, params \\ %{}) do
    case state do
      :success ->
        changeset(struct, params)
      :error ->
        changeset(struct, params)
        |> add_error(:name, "Password incorrect")
      _ ->
        changeset(struct, params)
      end
  end

  def hash_password(plaintext) do
    Bcrypt.hashpwsalt(plaintext)
  end

  def authenticate?(%{password: hash}, password) do
    Bcrypt.checkpw(password, hash)
  end
end
