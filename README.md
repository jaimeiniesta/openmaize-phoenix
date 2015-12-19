# Openmaize-phoenix

Examples of using Openmaize authentication / authorization library in a Phoenix web
application.

This example, on the `simple_admin` branch, is a simple example with just
one protected page, an admin page. There is no authentication performed
for any other page, which means that the `current_user` value will only
be set for the admin page.

## Openmaize

If you want to use this repository as an example of how to use Openmaize,
the most important files to look at are:

* config/dev.exs
  * configuring Openmaize
* web/router.ex
  * calling the Openmaize plugs
* web/controllers/admin_controller.ex
  * how authorization is handled -- using the plug function `authorize`
  * how the login GET request is handled
  * no logic is needed to handle the login POST request and the logout request
    * these are handled by the Openmaize.LoginoutCheck plug.
* web/templates/admin/login.html.eex
  * a login form

In the `web/router.ex` file, you will see the following Openmaize plugs:

* Openmaize.LoginoutCheck
  * check to see if path is for the login or logout page
  * handle login / logout if necessary
* Openmaize.Authenticate
  * authenticate the user using JSON Web Tokens (JWTs)
  * set the `current_user` variable with the information stored in the token
  * if there is no user, `current_user` will be set to nil

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
