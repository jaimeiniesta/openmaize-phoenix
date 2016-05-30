defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Openmaize.Authenticate
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index
    get "/confirm", PageController, :confirm
    get "/askreset", PageController, :askreset
    post "/askreset", PageController, :askreset_password
    get "/reset", PageController, :reset
    post "/reset", PageController, :reset_password
    get "/login", PageController, :login, as: :login
    post "/login", PageController, :login_user, as: :login
    get "/twofa", PageController, :twofa
    post "/twofa", PageController, :login_twofa
    delete "/logout", PageController, :logout, as: :logout
  end

  scope "/users", Welcome do
    pipe_through :browser

    resources "/", UserController, only: [:index, :show, :edit, :update]
  end

  scope "/admin", Welcome do
    pipe_through :browser

    get "/", AdminController, :index
    resources "/users", AdminController, only: [:new, :create, :delete]
  end

end
