# Openmaize-phoenix

Examples of using Openmaize authentication / authorization library in a Phoenix web
application.

There are two examples in this repository:

* A multiple roles example - on the `master` branch
  * there are multiple users and one admin
  * authentication is performed for every page
    * even unprotected pages authenticate the user
  * authorization is based on roles and the user id
* A simple admin example - on the `simple_admin` branch
  * there is just one admin
  * authentication is only performed for the admin page
    * unprotected pages do not check who the current user is

## Openmaize

If you want to use this repository as an example of how to use Openmaize,
the most important files to look at are:

* config/dev.exs
  * configuring Openmaize
* web/router.ex
  * calling the Openmaize.Authenticate plug
    * authenticates the user using JSON Web Tokens
    * sets the `current_user` value - if no user is found, this is set to nil
* web/controllers/admin_controller.ex
  * how authorization is handled - using the plug functions from the AccessControl module
* web/controllers/page_controller.ex
  * how login and logout is handled - using the Openmaize.Login and Openmaize.Logout plugs
* web/controllers/user_controller.ex
  * more examples of authorization - using the plug functions from the AccessControl module
* web/models/user.ex
  * how a new user is created - together with the `create` function in the admin_controller file
* web/templates/page/login.html.eex
  * the login form

### Optional password strength checker

This example uses a password strength checker which is an optional dependency of
Openmaize. If you don't want to use this, just remove the line `{:not_qwerty123, "~> 1.0"}`
from the deps in the mix.exs file.

## Installation

Follow these instructions to install this Phoenix app:

Edit the `config/dev.exs` and `priv/repo/seeds.exs` files before setting up the database
and then run the following commands:

    mix deps.get
    mix ecto.setup
    npm install
    mix phoenix.server

This app uses Stylus as a css preprocessor. If you don't want to use Stylus, remove
`stylus-brunch`, `jeet` and `rupture` from the package.json file before running
`npm install` and remove the stylus entry in the `brunch-config.js` file.

If you want to run Sass as a css preprocessor, run the following command:

    npm install --save sass-brunch

### License

MIT.
