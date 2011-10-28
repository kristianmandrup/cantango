module CanTango
  class Ability
    class Cache
      class SessionCache < BaseCache
        attr_accessor :session
        attr_reader   :key

        # will be called with :session => session (pointing to user session)
        def initialize name, options = {}
          super # will set all instance vars using options hash
          @cache = cache
          @cache.configure_with :type => :memory
          raise "SessionCache must be initialized with a :session option" if !session
          session[cache_key] = @cache
        end

        def cache_key
          @cache_key ||= :rules_cache
        end

        def store
          session[cache_key]
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

        def cache
          CanTango::Cache::HashCache.instance
        end
      end
    end
  end
end
