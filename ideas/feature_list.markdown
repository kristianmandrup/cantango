## Role Filters

In this case, disregard any permits relating to the :bloggers role
```ruby
user_can? :roles_filter => :bloggers
```

Config:

```ruby
CanTango.config.roles.filter :on
CanTango.config.roles.filter :off
```

Will use:

```ruby
CanTango.config.roles.register :admin

CanTango.config.roles.registered
CanTango.config.roles.registered
```

We should also have a #tango_role macro to add on the role class, which
will lazily execute Role.all somehow.

This should later be extended with:

```ruby
CanTango.config.roles.included :admin...
```

In Ability#initialize

```ruby
with(:permits) {|permit| break if permit.execute == :break }
...
```

Becomes

```ruby
with(:filtered_permits) {|permit| break if permit.execute == :break }
...
```

## Domain differentiation

Load specific permissions file (or permits) depending on which domain the user is in.
Would be nice to allow user to hook in and customize load logic in some
way. Have Session and Request obj available.

Also need some more documentation and specs on the use of special
permits Any and System. Any is last permit to always exectute (unless
flow broken). System is always first permit and can break off the flow, thus no
other permits may have effect after if broken.

Is there a need to enhance this with more control flow? Keep it simple!
