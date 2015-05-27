defmodule Welcome.Router do
  use Welcome.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :open_sesame
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Welcome do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index, as: :root
    get "/users/login", UserController, :login, as: :login
    post "/users/login", UserController, :login_user, as: :login
    post "/users/logout", UserController, :logout, as: :logout
    resources "/users", UserController
  end

  def open_sesame(conn, opts \\ []) do
    auth_list = ["users"]
    if Enum.any?(conn.path_info, fn x -> x in auth_list end) do
      Openmaize.Authenticate.call(conn, opts)
    else
      conn
    end
  end
end
