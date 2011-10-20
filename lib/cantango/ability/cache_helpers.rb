module CanTango
  class Ability
    module CacheHelpers

      def cached_rules?
        caching_on? && cache.key.same?(session)
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

      def any_caching_on?
        CanTango.config.cache_engine.on? || caching_on?
      end

      def caching_on?
        caching_on
      end
    end
  end
end
