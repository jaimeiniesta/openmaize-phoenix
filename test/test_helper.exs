ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.drop", ["--quiet"]
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]

ConnCase.Helper.add_users()

Ecto.Adapters.SQL.begin_test_transaction(Welcome.Repo)
