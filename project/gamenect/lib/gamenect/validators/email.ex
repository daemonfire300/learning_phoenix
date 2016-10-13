defmodule Gamenect.Validators.Email do
  import Ecto.Changeset
  @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
  # ensure that the email looks valid
  def validate_email(changeset, field) do
    changeset
    |> validate_format(field, @mail_regex)
  end 
end