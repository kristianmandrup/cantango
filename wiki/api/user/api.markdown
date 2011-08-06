Cantango comes with a Can API for both users and user accounts.

The User Account API is very similar to the User API.

* Can API
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

`#as_real_user` is used to explicitly negate masquerading within the
scope. Thus the permissions apply to the real user, not the masqueraded user.

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




