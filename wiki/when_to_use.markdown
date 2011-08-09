Choosing the right access control system is an important decission in
any project. The following is an attempt at an objective guide to help
you make the right decission.

It is important to stress, that it is never recommended to choose an
overly complex solution to handle simple requirements.
In many simple access control scenarios, a simple access control system
will do just fine and even allow for greater flexibility!

## When to use CanCan

CanCan is useful to use on its own when:

* Access rule requirements are simple
* There are few roles (and/or role groups)
* A few can? statements in critical views and controllers
* Access is mostly controlled on the controller REST method level
* Guest user logic is simple
* You have a simple User model class and a #current_user method that
  works for all logged in users.

If this fits with your requirements, by all means start off with just
CanCan. It should be pretty easy to upgrade to CanTango if you need to
in the future.

## When to use CanTango

If you find that your requirements go beyond what CanCan can satisfy out
of the box without too much tweaking on your own part, CanTango just
might be the solution you are looking for.

Complexity and fine control
* Access rule requirements are somewhat complex
* Access must be controlled on a more fine grained level

Users
* You have multiple types of users, fx User, Guest and Admin
* There are more than a few roles (and/or role groups)

Performance
* Access control should be fast, you need caching of permits for each user
* Users not logged in should be granted a Guest user instance

User accounts:
* Your app has multiple User accounts, one for each sub-app
* Access control logic can differ for each account
* A user can be logged into one or more accounts simultaneously
* Some users are allowed to masquerade as other users
* Some users are allowed to masquerade as if logged into a
  different account

Administration
* Access control (permisssions) should be maintained in logical
  containers, on a per-role or role group basis
* Access control should be maintained and administrated in a permission
  store, fx a Yaml file

If more than a few items on this list reflect your requirements, give
CanTango a chance!

If your requirements go beyond this, create your own extension or even
better help enhance CanTango directly!

Have FUN! Let's Tango!
