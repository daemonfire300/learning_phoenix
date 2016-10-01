defmodule Gamenect.AuthPlug do
    import Plug.Conn
    alias Gamenect.User

    def init(default), do: default
    def is_moderator(conn, default) do
        %User{:name => username} = Guardian.Plug.current_resource(conn)
        Enum.member?(default, username)
    end
    @doc """
    This plug assume that there is a current ressource, and checks wether this user has admin privilige.
    """
    def requires_moderator(conn, default) do
        case is_moderator(conn, default) do
            true ->
                conn
            _ ->
                conn
                |> Phoenix.Controller.put_flash(:error, "You need admin priviliges")
                |> Phoenix.Controller.redirect(to: "/")
                |> halt
        end
    end

    def call(conn, default) do
        requires_moderator(conn, default)
    end
end