module CanTango
  class Ability
    module Cache
      module Reader

        def rules_loaded
          rules_cache.load(cache_key)
        end

        def load_rules
          compile_on? ? decompile_rules!(rules_loaded) : rules_loaded
        end

        def cached_rules?
          caching_on? && cache_key_same?
        end

        def cached_rules
          @rules ||= load_rules
        end
      end
    end
  end
end

