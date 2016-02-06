defmodule Welcome.PageController do
  use Welcome.Web, :controller

  alias Openmaize.Confirm
  alias Welcome.Mailer

  plug Openmaize.Login, [unique_id: :email] when action in [:login_user]
  plug Openmaize.Logout when action in [:logout]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def confirm(conn, _params) do
    case Confirm.user_email(conn, key_expires_after: 10) do
      {:ok, _user, email} ->
        Mailer.receipt_confirm(email)
        conn
        |> put_flash(:info, "You have successfully confirmed your account.")
        |> redirect(to: login_path(conn, :login))
      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: page_path(conn, :index))
    end
  end
end
