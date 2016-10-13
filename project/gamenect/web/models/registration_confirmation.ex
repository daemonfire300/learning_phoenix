defmodule Gamenect.RegistrationConfirmation do
  use Gamenect.Web, :model

  schema "confirmations" do
    field :token, :string
    belongs_to :user, Gamenect.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token])
    |> validate_required([:token])
  end
end
