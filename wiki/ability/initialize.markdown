The CanTango::Ability is initialized with a candidate and an options
hash.

## Candidate

The candidate... subject, user, active user - masquerading, ...

## Options hash

When used from a web framework such as Rails, the options hash
should be populated with essential objects such as:

* Request
* Session
* Params

This will make these objects available to the permission rules for evaluation.
Some rules might be dependent on whether the user is accessing the site
from localhost or if the user has a given session state.

## The Flow

1. Use cached rules if available for user
2. Generate rules for user
3. Cache rules for user

### Use cache rules

See [[Rules cache]]

### Generate rules

1. Generate Permission rules from store
2. Generate Permit rules from classes

### Cache rules

Generate a unique hash key for the user and marshal all the rule in a
store with that key as identifier. If the user changes, the rules
for the old key will be invalidated and new rules generated for the new
key.


