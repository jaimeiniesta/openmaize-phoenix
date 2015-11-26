defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.LoginoutCheck
    #plug Openmaize.LoginoutCheck, token_validity: 10
    plug Openmaize.Authenticate
  end

  pipeline :authorize do
    #plug Openmaize.Authorize
    plug Openmaize.Authorize.IdCheck
    #plug Openmaize.Authorize.IdCheck, show: true
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Openmaize.LoginoutCheck
    plug Openmaize.Authenticate
    plug Openmaize.Authorize.IdCheck, redirects: false
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index, as: :root
  end

  scope "/users", Welcome do
    pipe_through [:browser, :authorize]

    resources "/", UserController, only: [:index, :show, :edit, :update]
  end

  scope "/admin", Welcome do
    pipe_through [:browser, :authorize]

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
