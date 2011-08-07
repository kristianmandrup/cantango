The Cantango Cache engine is used to cache rules between requests. It will be referenced here as the 'rules cache'. 

The rules cache needs a store to store the rules. Cantango is setup to
use a Session store by default. The session store is internally setup to
wrap a Moneta memory store.

To configure the cache store for the rules cache:

```ruby
Cantango.configure do |config|
  config.cache.store do |store|
    store.default Cantango::Cache::MonetaCache
    store.default_type :redis
    store.options = {:port => 5032}
  end
end
```

