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


