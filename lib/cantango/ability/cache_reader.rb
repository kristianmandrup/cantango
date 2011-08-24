module CanTango
  class Ability
    class CacheReader

      attr_reader :cache

      def initialize cache
        @cache = cache
      end

      protected

      def prepared_rules
        cache.compile_on? ? cache.compiler.decompile!(loaded_rules) : loaded_rules
      end

      def loaded_rules
        cache.rules_cache.load(cache.key)
      end
    end
  end
end

