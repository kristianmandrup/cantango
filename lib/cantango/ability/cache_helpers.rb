module CanTango
  class Ability
    module CacheHelpers

      def cached_rules?
        caching_on? && cache.key.same?
      end

      def cache_rules!
        cache_writer.save cache.key, compiled_rules
      end

      def cached_rules
        cache.cached_rules
      end

      protected

      def caching_on?
        CanTango.config.cache.on?
      end
    end
  end
end
