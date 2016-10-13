defmodule Gamenect.LobbyView do
  use Gamenect.Web, :view

  def status_to_text(status) when is_integer(status) do
    case status do
      0 ->
        "closed"
      1 ->
        "open"
      2 ->
        "private"
    end
  end

  def status_to_text(_status) do
    "unknown"
  end

  def status_to_icon(status) when is_integer(status) do
    case status do
      0 ->
        "glyphicon glyphicon-remove status-closed"
      1 ->
        "glyphicon glyphicon-ok status-open"
      2 ->
        "glyphicon glyphicon-user status-private"
    end
  end

  def status_to_icon(_) do
    "glyphicon glyphicon-flash"
  end

  def is_owner(nil, _) do
    false
  end
  
  def is_owner(user, lobby) do
    user.id == lobby.host.id
  end

end
