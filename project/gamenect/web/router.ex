defmodule Gamenect.Router do
  use Gamenect.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do  
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end  

  scope "/", Gamenect do
    pipe_through [:browser, :browser_auth]

    get "/", LobbyController, :index
    get "/lobby/join/:id", LobbyController, :join
    resources "/users", UserController
    resources "/lobbies", LobbyController
    resources "/user_lobby", UserLobbyController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Gamenect do
  #   pipe_through :api
  # end
end
