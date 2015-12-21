# Openmaize-phoenix

Examples of using Openmaize authentication / authorization library in a Phoenix web
application.

There are two examples in this repository:

* A multiple roles example -- on the `master` branch
  * there are multiple users and one admin
  * authentication is performed for every page
    * even unprotected pages authenticate the user
  * authorization is based on roles and the user id
* A simple admin example -- on the `simple_admin` branch
  * there is just one admin
  * authentication is only performed for the admin page
    * unprotected pages do not check who the current user is

## Openmaize

If you want to use this repository as an example of how to use Openmaize,
the most important files to look at are:

* config/dev.exs
  * configuring Openmaize
* web/router.ex
  * calling the Openmaize module plugs
* web/controllers/admin_controller.ex
  * how authorization is handled -- using the plug functions from the AccessControl module
  * how the login GET request is handled
  * no logic is needed to handle the login POST request and the logout request
    * these are handled by the Openmaize.LoginoutCheck plug.
* web/controllers/user_controller.ex
  * more examples of authorization -- using the plug functions from the AccessControl module
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
