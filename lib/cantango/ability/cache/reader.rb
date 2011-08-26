module CanTango
  class Ability
    class Cache
      class Reader
        attr_reader :cache

        def initialize cache
          @cache = cache
        end

        def prepared_rules
          cache.compile_on? ? compiler.decompile!(loaded_rules) : loaded_rules
        end

        protected

        def loaded_rules
          rules_cache.load(cache.key)
        end

        def compiler
          cache.compiler
        end

        def rules_cache
          cache.rules_cache
        end
      end
    end
  end
end

