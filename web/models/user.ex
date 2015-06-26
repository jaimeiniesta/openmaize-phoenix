defmodule Welcome.User do
  use Welcome.Web, :model

  alias Welcome.Repo

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :role, :string
    field :bio, :string

    timestamps
  end

  @required_fields ~w(name email password_hash role)
  @optional_fields ~w(bio)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:name, on: Repo)
  end
end
