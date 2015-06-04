# Openmaize-example

An example of using Openmaize, an authentication library, in a Phoenix web
application.

To see how Openmaize is called, see the `config/dev.exs` and `web/router.ex`
files.

In this example, Openmaize is called for every connection and handles the
authentication of users using Json Web Tokens (JWTs). It also handles the
login and logout of users.

Openmaize uses roles to offer finer-grained protection, and so the user
model needs to have a `role` entry, as well as `id` and `name`. The "admin"
role is allowed complete access to anywhere on the site. In addition, if a
role's path is followed by an id, other users' pages can be viewed, but not
edited. So, in this example, harry can view dick's page, but he is not
allowed to edit it. See the `config/dev.exs` file for an example of how
to configure role protection.

`current_user` is set for every connection (it is set to nil if nobody is
logged in), and so `@current_user` will be available in all of the templates.
