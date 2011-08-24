module CanTango
  class Ability
    class Cache
      class Writer
        attr_reader :cache

        def initialize cache
          @cache = cache
        end

        def save key, rules
          cache.invalidate!
          cache.rules_cache.save cache.key, prepared_rules
          session[:cache_key] = cache_key if session
        end

        protected

        def prepared_rules
          compile_on? ? cache.compiler.compile!(rules) : rules
        end

        def rules
          return cache.cached_rules if cache.cached_rules?
          super
        end
      end
    end
  end
end
