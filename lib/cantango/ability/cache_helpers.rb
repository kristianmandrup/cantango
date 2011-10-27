module CanTango
  class Ability
    module CacheHelpers

      def cached_rules?
        cache.key.same?(session)
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
    end
  end
end
