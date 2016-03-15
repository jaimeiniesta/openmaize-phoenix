defmodule Welcome.AuthorizeTest do
  use Welcome.ConnCase

  test "authorize_action succeeds when current_user has the right role" do
  end

  test "authorize_action fails when current_user is nil" do
  end

  test "authorize_action fails when current_user is not the correct role" do
  end

  test "id_check succeeds for correct id" do
  end

  test "id_check fails for incorrect id" do
  end

  test "handle_login redirects to user's role's page on login" do
  end

  test "handle_login fails if there is an error message" do
  end

  test "handle_confirm redirects to the login page if successful" do
  end

  test "handle_confirm fails if there is an error message" do
  end

  test "handle_reset redirects to the login page if successful" do
  end

  test "handle_reset rerenders the reset password form if there is an error" do
  end

end
