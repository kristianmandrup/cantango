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

