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


end
