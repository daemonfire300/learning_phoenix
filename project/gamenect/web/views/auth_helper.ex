defmodule Gamenect.AuthHelper do
    def current_user(conn), do: Guardian.Plug.current_resource(conn)
    def logged_in?(conn), do: Guardian.Plug.authenticated?(conn)
    def is_allowed?(conn, acl) do
        Gamenect.AuthPlug.is_moderator(conn, acl)
    end
end