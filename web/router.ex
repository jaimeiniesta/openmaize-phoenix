defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug Openmaize.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index, as: :root

    resources "/users", UserController

    get "/admin", AdminController, :index
    get "/admin/login", AdminController, :login, as: :login
    post "/admin/login", AdminController, :login_user, as: :login
    get "/admin/logout", AdminController, :logout, as: :logout
  end

end
