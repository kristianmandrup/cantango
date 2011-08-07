Cantango is by default setup to autoload:

* Models (app/models)
* Permits (app/permits)

The autoloading is performed as part of the Cantango Rails engine initialization.

To configure autoloading:

```ruby
Cantango.configure.autoload do |load|
  load.models :off
  load.permits :on
end
```

## Models autoloading

Models are autoloaded in order to be sure that the Cantango class macros such as `#tango_user` are executed
and thus that User and Account modesl are registered with Cantango.

If you don't wont to autoload the models for performance or other
reasons, you can alternatively register the models directly (see [Models
registration]]).

## Permits autoloading

Permits autoloading is done so as to ensure they are made available to
CanTango::Ability. If you want full control over which Permits are
loaded when, you can disable this feature.

