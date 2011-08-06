The Cantango Cache engine is used to cache rules between requests. The
[[Cantango Ability]] receives a candidate and an options hash.

If caching is enabled, caching proceeds as follows:

1. Cache key is generated for candidate
2. Rules are generated
3. Rules are stored in Caching store for the cache key
4. In subsequent requests with same key, rules are retrieved from cache

## Cache key

A cache key is generated for the candidate in order to ensure that the
rules are cached for that exact candidate and not reused for another
candidate.


