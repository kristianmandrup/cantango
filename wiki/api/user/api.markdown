Cantango comes with a Can API and a Scope API for users

* Can API
* Scope API

The following examples assume we have the user models User and Admin registered as Cantango users.
See [[Registration of User models]].

## User Can API

The Can API is very similar to the CanCan API but instead uses a CanTango::Ability for a specific kind of current user.
The devise methods `#current_xxxx` such as current_user, current_admin etc. are wll integrated in the Can API.
For the user models User and Admin, Cantango will provide the following API:

API methods:
* user_can? actions, targets
* admin_can? actions, targets

Example use:

```ruby
if user_can? :edit, Article
  # do sth
end
```

```ruby
if admin_can? :manage, Article
  # do sth
end
```

## User Scope API

The Scope API is useful when you want to do several ability tests for the same kind of user.

API methods:
* scope_user type, options = {}, &block
* as_real_user type, options = {}, &block

`#scope_user` is used to define an ability scope for a specific user. The
permission API can then operate on this ability scope directly instead
of having to create the ability each time.

Example use #scope_user:

```ruby
scope_user :admin do |admin|
  if admin.can?(:edit, Article) || admin.can?(:read, Post)
    # do stuff
  end
  if admin.can? :delete, Article
    # delete link here
  end
end
```

`#as_real_user` is used to explicitly negate masquerading within the scope.
Thus the permissions apply to the real user, not the masqueraded user.

Assume we have an app divided into a public app and an admin app.

For an Admin user it could make sense to masquerade as a Public user in
the public part of the application, but remain as an Admin user in the
admin app while remaining in the same session.

This can be achieve using `#as_real_user` in the admin app.

Example use #as_real_user:

```ruby
as_real_user :admin do |admin|
  if admin.can?(:edit, Article) || admin.can?(:read, Post)
    # do stuff
  end
  if admin.can? :delete, Article
    # delete link here
  end
end
```

