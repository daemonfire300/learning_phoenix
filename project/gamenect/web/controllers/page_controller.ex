defmodule Gamenect.PageController do
  use Gamenect.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
