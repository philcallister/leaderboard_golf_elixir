defmodule LeaderboardGolf.Router do
  use LeaderboardGolf.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LeaderboardGolf do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/tournaments", TournamentController, except: [:new, :edit, :index]
    resources "/tournaments", TournamentController do
      resources "/rounds", RoundController, only: [:index]
      resources "/players", PlayerController, only: [:index]
      resources "/courses", CourseController, only: [:index]
    end
    resources "/courses", CourseController, except: [:new, :edit, :index] do
      resources "/holes", HoleController, only: [:index]
    end
    resources "/rounds", RoundController, except: [:new, :edit, :index] do
      resources "/cards", CardController, only: [:index]
    end
    resources "/players", PlayerController, except: [:new, :edit, :index] do
      resources "/cards", CardController, only: [:index]
    end
    resources "/cards", CardController, except: [:new, :edit, :index] do
      resources "/scores", ScoreController, only: [:index]
    end
    resources "/holes", HoleController, except: [:new, :edit, :index]
    resources "/scores", ScoreController, except: [:new, :edit, :index]
  end

end
