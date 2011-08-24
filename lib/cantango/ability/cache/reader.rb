module CanTango
  class Ability
    class Cache
      class Reader
        attr_reader :cache

        def initialize cache
          @cache = cache
        end

        def prepared_rules
          cache.compile_on? ? cache.compiler.decompile!(loaded_rules) : loaded_rules
        end

        protected

        def loaded_rules
          cache.rules_cache.load(cache.key)
        end
      end
    end
  end
end

