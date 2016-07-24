defmodule LeaderboardGolf.Router do
  use LeaderboardGolf.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LeaderboardGolf do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/tournaments", TournamentController, except: [:new, :edit]
    resources "/tournaments", TournamentController do
      resources "/rounds", RoundController, only: [:index]
    end
    resources "/rounds", RoundController, except: [:new, :edit, :index]
  end

end
