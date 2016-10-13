defmodule Gamenect.Email do
  use Bamboo.Phoenix, view: Gamenect.EmailView

  def welcome_text_email(email_address) do
    new_email
    |> to(email_address)
    |> from("postmaster@sandbox2d876dea6fe0444ca5b58499d836b588.mailgun.org")
    |> subject("Welcome!")
    |> text_body("Welcome to MyApp!")
  end
end