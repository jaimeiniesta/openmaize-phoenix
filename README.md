# Openmaize-phoenix

An example of using Openmaize authentication library in a Phoenix web
application.

To see how Openmaize is called, see the `config/dev.exs` and `web/router.ex`
files. In addition, see the `web/controllers/admin_controller.ex` file
and the login and login_form templates to see how the login GET request
is handled. It is not necessary to write any logic for the login POST request
and the logout request as those are handled by Openmaize.

In the `web/router.ex` file, you will see that there are three Openmaize plugs
being used: Openmaize.LoginoutCheck, Openmaize.Authenticate and Openmaize.Authorize.

Openmaize.LoginoutCheck checks to see if the path is for the login or logout page
and then handles the login or logout process if necessary.

Openmaize.Authenticate authenticates the user using Json Web Tokens (JWTs) and
sets the `current_user` variable, and so `@current_user` will be available in
all of the templates. If there is no user, `current_user` will be set to nil.

Openmaize uses roles to offer finer-grained protection, and so the user
model needs to have a `role` entry, as well as `id` and `name`.
