defmodule Welcome.Router do
  use Welcome.Web, :router
  import Openmaize.IdCheck

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug Openmaize, check: &id_noedit/4
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Openmaize, redirects: false
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index, as: :root

    resources "/users", UserController, only: [:index, :show, :edit, :update]
  end

  scope "/admin", Welcome do
    pipe_through :browser

    get "/", AdminController, :index
    get "/login", AdminController, :login, as: :login
    post "/login", AdminController, :login_user, as: :login
    get "/logout", AdminController, :logout, as: :logout

    resources "/users", AdminController, only: [:new, :create, :delete]
  end

  scope "/api", Welcome do
    pipe_through :api

    post "/login", ContactController, :login
    resources "/users", ContactController
  end

end
