The User Account API is very similar to the User API.

* Can API
* Actie API
* Scope API

Assume we have the account models UserAccount and AdminAccount registered with Cantango.(See [[Registration of User Account models]])

## Can API

Example use:

```ruby
if user_account_can? [:edit, :delete], Article
  # do sth
end
```

