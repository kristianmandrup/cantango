require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Cache < Engine
        include Singleton

        def store &block
          @store ||= ns::Store.new
          # CanTango::Ability::Cache::MonetaCache
          @store.default_class ||= CanTango::Ability::Cache::SessionCache
          yield @store if block
          @store
        end
      end
    end
  end
end


