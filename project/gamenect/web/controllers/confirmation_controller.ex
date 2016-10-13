defmodule Gamenect.ConfirmationController do
  use Gamenect.Web, :controller

  alias Gamenect.RegistrationConfirmation

  plug Guardian.Plug.EnsureAuthenticated when action in [:confirm]

  def confirm(conn, %{"token" => token}) do
    case Repo.get_by(RegistrationConfirmation, token: token) do
      nil ->
        conn
        |> put_flash(:error, "No such token")
        |> redirect(to: lobby_path(conn, :index))
      confirmation ->
        user = confirmation |> Repo.preload(:user)
        IO.inspect(allow?(conn, user))
        conn
        |> put_flash(:info, "User Confirmed")
        |> redirect(to: lobby_path(conn, :index))
      end
  end

  def allow?(conn, %Gamenect.User{} = user) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        false
      %Gamenect.User{} = curr_user ->
          curr_user.id == user.id
      _ ->
        false
    end
  end

  def allow?(_conn, _) do
    false
  end
end