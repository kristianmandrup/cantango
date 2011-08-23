module CanTango
  class Ability
    module Cache
      module Writer

        def cache_rules!
          return if !caching_on?
          invalidate_cache!
          rules_cache.save cache_key, compiled_rules
          session_check!
          session[:cache_key] = cache_key
        end

        protected

        def invalidate_cache!
          session_check!
          rules_cache.invalidate! session[:cache_key]
        end

        def compiled_rules
          compile_on? ? compile_rules!(rules) : rules
        end
      end
    end
  end
end
