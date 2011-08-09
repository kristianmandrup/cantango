Maquerading is the concept of one user acting as though he/she was
another user. In Cantango we enhance this to also be possible to
masquerade account login if needed.

In order to masquerade, you simply do:

```ruby
user.masquerade_as other_user
```

If you are using the 'friendly_id' gem, you can even do:

```ruby
admin_user.masquerade_as 'stanislaw'
```

This requires that you have configured your user model with a friendly id, in this case `username`.

## Masquerading accounts

Account masquerading allows a user to act as if he is logged into
another account.

```ruby
admin_account.masquerade_as normal_account
```



