module CanTango
  class Ability
    module Cache
      class SessionCache < BaseCache
        attr_accessor :session

        # will be called with :session => session (pointing to user session)
        def initialize name, options = {}
          super # will set all instance vars using options hash
          @cache = cache
          @cache.configure_with :type => :memory
          raise "SessionCache must be initialized with a :session option" if !session
          session[:rules_cache] = @cache
        end

        def store
          session[:rules_cache]
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
          # CanTango::Cache::MonetaCache.instance
        end
      end
    end
  end
end
