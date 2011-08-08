If you don't want to enable models autoloading but have them remain
lazy-loaded as is the Rails 3 defult, you have to register the core
models used by Cantango.

In Cantango, registration is done through a Registry like this:

```ruby
Cantango.configure do |config|
  config.users.register :user, :admin
  config.user_accounts.register :user, :admin
end
```


