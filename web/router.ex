defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorize do
    plug Openmaize.Authenticate
  end

  scope "/", Welcome do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", PageController, :login, as: :login
    post "/login", PageController, :login_user, as: :login
    get "/logout", PageController, :logout, as: :logout
  end

  scope "/admin", Welcome do
    pipe_through [:browser, :authorize]

    get "/", AdminController, :index
  end

end
