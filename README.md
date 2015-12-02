# Openmaize-phoenix

An example of using Openmaize authentication library in a Phoenix web
application.

## Openmaize

If you want to use this repository as an example of how to use Openmaize,
the most important files to look at are the `config/dev.exs` and `web/router.ex`
files.

In addition, see the `web/controllers/admin_controller.ex` file
and the login and login_form templates to see how the login GET request
is handled. It is not necessary to write any logic for the login POST request
and the logout request as those are handled by Openmaize.

In the `web/router.ex` file, you will see the following four Openmaize plugs
being used (some of these are commented out in this example):

* Openmaize.LoginoutCheck
  * check to see if path is for the login or logout page
  * handle login / logout if necessary
* Openmaize.Authenticate
  * authenticate the user using JSON Web Tokens (JWTs)
  * set the `current_user` variable with the information stored in the token
  * if there is no user, `current_user` will be set to nil
* Openmaize.Authorize
  * check to see if the user is authorized to access the resource / url
  * this check is based on the user's role
* Openmaize.Authorize.IdCheck
  * perform the Authorize check and then check that the id matches the current user id

## Installation

Follow these instructions to install this Phoenix app:

Edit the `config/dev.exs` and `priv/repo/seeds.exs` files before setting up the database
and then run the following commands:

    mix ecto.setup
    npm install

This app uses Stylus as a css preprocessor. If you don't want to use Stylus, remove
`stylus-brunch`, `jeet` and `rupture` from the package.json file before running
`npm install` and remove the stylus entry in the `brunch-config.js` file.

### License

MIT.
