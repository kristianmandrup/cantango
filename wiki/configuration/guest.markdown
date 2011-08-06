CanTango operates with the concepts of a Guest user and a Guest account.

## Guest user

In case the `curent_xxx_` method does't return a valid user, Cantango will attempt to return
a guest user according to configuration and conventions.

If Cantango has not been configured with specific Guest user configuration, it will see if the User model
is available. If so, it will call `#guest` on it (if method available).

## Configuration

Cantango should be configured with how to retrieve (or create) such a guest user via:

`CanTango::Configuration.guest.user obj`

The `obj` argument can be either:

* User instance
* A procedure in the form of a lambda or Proc
* A block

The Guest user should normally have restricted permission rules, mostly only :read access.
We recommend setting the Guest permission rules to: `can :read, :all` and refine from there.

## Guest user account

In case the `curent_xxx_account` method does't return a valid user account, Cantango will attempt to return
a guest user account according to configuration and conventions.

If Cantango has not been configured with specific Guest user account configuration, it will see if the UserAccount model 
is available. If so, it will call `#guest` on it (if method available).

## Configuration

Cantango should be configured with how to retrieve (or create) such a guest user via:

`CanTango::Configuration.guest.account obj`

The `obj` argument can be either:

* UserAccount instance
* A procedure in the form of a lambda or Proc
* A block

The Guest user account should usually be setup to have a guest user only.


