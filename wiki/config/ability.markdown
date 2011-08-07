You can configure your own Ability factory.

```ruby

class MyCustomAbility < CanTango::Ability
  def initialize
    # super ?
    # custom logic
  end
end

Cantango.configure.ability do |ability|
  ability.factory { MyCustomAbility }
end
```

This feature is currently also used for performance testing of Cantango!

