defmodule Welcome.Gettext do
  @moduledoc """
  A module providing Internationalization with a gettext-based API.

  See the [Gettext Docs](http://hexdocs.pm/gettext) for details.
  """
  use Gettext, otp_app: :welcome
end
