The User Account API is very similar to the User API and is divided into
a Can API and a Scope API.

* Can API
* Scope API

Assume we have the account models UserAccount and AdminAccount registered as Cantango users.
See [[Registration of User Account models]] for details.

## Account Can API

The Account Can API expects methods in the form `#current_xxxx` are available for each type of user account.
In our scenario, `#current_user_account` and `#current_admin_account` should be available.
Cantango will provide the following API:

API methods:
* user_can? actions, targets
* admin_can? actions, targets

Example use:

```ruby
if user_account_can? :edit, Article
  # do sth
end
```

```ruby
if admin_account_can? :manage, Article
  # do sth
end
```

## Account Scope API

The Scope API is useful when you want to do several ability tests for the same kind of user account.

API methods:
* scope_acount type, options = {}, &block
* as_real_account type, options = {}, &block

`#scope_account` is used to define an ability scope for a specific user account. The
permission API can then operate on this ability scope directly instead
of having to create the ability each time.

Example use #scope_account:

```ruby
scope_account :admin do |account|
  if account.can?(:edit, Article) || account.can?(:read, Post)
    # do stuff
  end
  if account.can? :delete, Article
    # delete link here
  end
end
```

`#as_real_acount` is used to explicitly negate masquerading within the scope.
Thus the permissions apply to the real account, not the masqueraded account.

Assume we have an app divided into a public app and an admin app.

For an Admin user it could make sense to masquerade as if he was logged
in to the Public account in the public part of the application. 
The admin should remain as an Admin user on the Admin account when
accessing the admin app, while remaining in the same session.

This can be achieve using `#as_real_account` in the admin app.

Example use #as_real_account:

```ruby
as_real_account :admin do |account|
  if account.can?(:edit, Article) || account.can?(:read, Post)
    # do stuff
  end
  if account.can? :delete, Article
    # delete link here
  end
end
```

