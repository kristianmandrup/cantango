Cantango comes with a Can API for both users and user accounts.

The User Account API is very similar to the User API.

* Can API
* Actie API
* Scope API

Assume we have the user models User and Admin registered with Cantango.(See [[Registration of User models]])

## User Can API

The Can API is very similar to the CanCan API but instead initialized a CanTango::Ability with a specific kind of current user.
The devise methods `#current_xxxx` such as current_user, current_admin etc. are all integrated this way.

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

The scope API is useful when you want to do several ability tests with
the same kind of user.

API methods:
* scope_user type, options = {}, &block

Example use:

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

## User Active API

Note: Why not integrate with other apis?

if active_user points to another user, this user should always be the
one considered for permissions!

The Active API is used when user masquerading must be considered.
When an Admin user masquerades as a normal user, the admin must have the permissions
of the normal user. Hence the normal user is the active user for the admin.

API methods:
* active_user type, options = {}, &block

Example use:

```ruby
active_user :admin do |admin|
  if admin.can?(:edit, Article) || admin.can?(:read, Post)
    # do stuff
  end
  if admin.can? :delete, Article
    # delete link here
  end
end
```


