defmodule Welcome.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password_hash, :string
      add :role, :string
      add :confirmed_at, :datetime
      add :confirmation_token, :string
      add :confirmation_sent_at, :datetime
      add :bio, :string

      timestamps
    end

    create unique_index :users, [:email]
  end
end
