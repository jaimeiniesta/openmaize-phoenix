defmodule Welcome.Mailer do
  @moduledoc """
  An example module for sending emails.

  This example uses `mailgun`, but there are also other options available,
  such as `mailman`.
  """

  use Mailgun.Client, domain: Application.get_env(:welcome, :mailgun_domain),
                      key:    Application.get_env(:welcome, :mailgun_key),
                      mode: :test, # these two lines are only for testing
                      test_file_path: "/tmp/mailgun.json"

  @from "norwegianblue@example.com"

  @doc """
  An email with a confirmation link in it.
  """
  def ask_confirm(email, link) do
    confirm_url = "http://www.example.com/confirm?#{link}"
    send_email to: email,
              from: @from,
              subject: "Request confirmation",
              html: Phoenix.View.render_to_string(Welcome.EmailView, "ask_confirm.html", %{confirm_url: confirm_url})
  end

  @doc """
  An email acknowledging that the account has been successfully confirmed.
  """
  def receipt_confirm(email) do
    send_email to: email,
              from: @from,
              subject: "Successful confirmation",
              html: Phoenix.View.render_to_string(Welcome.EmailView, "receipt_confirm.html", %{})
  end
end
