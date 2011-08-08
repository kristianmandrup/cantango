require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Cache < Engine
        include Singleton

        def store &block
          @store ||= ns::Store.instance
          @store.default_class = CanTango::Ability::Cache::MonetaCache
          yield @store if block
          @store
        end
      end
    end
  end
end


