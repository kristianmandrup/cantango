require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Cache
        include Singleton

        def store &block
          @store ||= Store.instance
          @store.default = CanTango::Ability::SessionCache
          yield @store if block
          @store
        end
     end
    end
  end
end


