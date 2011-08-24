require 'moneta'
require 'active_support/inflector'

module CanTango
  class Ability
    class Cache
      class MonetaCache
        # one cache store is shared for all store instances (w different names)
        attr_reader :store

        # for a YamlStore, the name is the name of the yml file
        def initialize name, options = {}
          super
          @store = CanTango::Cache::MonetaCache.instance
          @store.configure_with options
        end

        def load key
          store.load! key
        end

        def save key, rules
          store.save! key, rules
        end

        def invalidate! key
          store.delete key
        end
      end
    end
  end
end
