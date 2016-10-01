defmodule Gamenect.GameView do
  use Gamenect.Web, :view
    def render("list.json", %{games: games}) do
    %{games: render_many(games, Gamenect.GameView, "single_game.json")}
  end

  def render("show.json", %{game: game}) do
    %{game: render_one(game, Gamenect.GameView, "single_game.json")}
  end

  def render("single_game.json", %{game: game}) do
    %{id: game.id, title: game.title}
  end
end
