You can configure your own Ability factory.

```ruby

class MyCustomAbility < CanTango::Ability
  def initialize name, options = {}
    # super
    # custom logic
  end
end

Cantango.configure.ability do |ability|
  ability.factory Proc.new{|name, options| MyCustomAbility.new name, options }
end
```

This feature is currently also used for performance testing of Cantango!

