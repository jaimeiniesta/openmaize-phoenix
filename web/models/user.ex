defmodule Welcome.User do
  use Welcome.Web, :model

  import Comeonin.Bcrypt
  import NotQwerty123.PasswordStrength

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
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 8, max: 80)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        #put_change(changeset, :password_hash, hashpwsalt(password))
        check_pword_put_change(changeset, password)
      _ -> changeset
    end
  end

  defp check_pword_put_change(changeset, password, opts \\ []) do
    case strong_password?(password, opts) do
      true -> put_change(changeset, :password_hash, hashpwsalt(password))
      message -> add_error(changeset, :password, message)
    end
  end
end
