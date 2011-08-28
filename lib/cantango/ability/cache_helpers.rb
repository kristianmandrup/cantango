module CanTango
  class Ability
    module CacheHelpers

      def cached_rules?
        caching_on? && cache.key.same?
      end

      def cache_rules!
        cache.cache_rules!
      end

      def cached_rules
        cache.cached_rules
      end

      def cache
        @cache ||= Cache.new self
      end

      protected

      def caching_on?
        CanTango.config.cache_engine.on?
      end
    end
  end
end
