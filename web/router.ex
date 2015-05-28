defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :authenticate do
    plug Openmaize.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index, as: :root
  end

  scope "/users", Welcome do
    pipe_through [:browser, :authenticate]

    get "/login", UserController, :login, as: :login
    post "/login", UserController, :login_user, as: :login
    get "/logout", UserController, :logout, as: :logout
    resources "/", UserController
  end

  scope "/admin", Welcome do
    pipe_through [:browser, :authenticate]

    get "/", AdminController, :index
  end

end
