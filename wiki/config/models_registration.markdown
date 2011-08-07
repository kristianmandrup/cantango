If you don't want to enable models autoloading but have them remain
lazy-loaded as is the Rails 3 defult, you have to register the core
models used by Cantango:

```ruby
Cantango.configure do |config|
  config.users = :user, :admin
  config.user_accounts = :user, :admin
end
```


