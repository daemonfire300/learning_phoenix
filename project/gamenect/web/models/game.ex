defmodule Gamenect.Game do
  use Gamenect.Web, :model

  schema "games" do
    field :title, :string
    field :category, :string
    field :image, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :category, :image])
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :category, :image])
    |> validate_required([:title, :category, :image])
  end

  def search_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_length(:title, min: 3)
  end
end
