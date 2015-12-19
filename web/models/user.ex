defmodule Welcome.User do
  use Welcome.Web, :model

  alias Openmaize.Signup

  schema "users" do
    field :name, :string
    field :role, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :bio, :string

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name role), ~w(email bio))
    |> validate_length(:name, min: 1, max: 100)
    |> unique_constraint(:name)
  end

  def auth_changeset(model, params) do
    model
    |> changeset(params)
    |> Signup.create_user(params)
  end
end
