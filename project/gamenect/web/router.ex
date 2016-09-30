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

  pipeline :needs_admin do
    plug Guardian.Plug.EnsureAuthenticated, handler: Gamenect.UserController
    plug Gamenect.AuthPlug
  end

  scope "/admin", Gamenect do
    pipe_through [:browser, :browser_auth, :needs_admin]
    resources "/games", GameController
  end

  scope "/", Gamenect do
    pipe_through [:browser, :browser_auth]

    get "/", LobbyController, :index
    get "/lobby/join/:id", LobbyController, :join
    resources "/users", UserController
    resources "/lobbies", LobbyController
    resources "/user_lobby", UserLobbyController
    get "/login", UserController, :login
    post "/login", UserController, :login
    get "/logout", UserController, :logout
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Gamenect do
    pipe_through :api
    get "/game", GameController, :search
  end
end
