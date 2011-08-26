module CanTango
  class Ability
    class Cache
      autoload_modules :Kompiler
    end
  end
end

CanTango.config.adapters.register :compiler
