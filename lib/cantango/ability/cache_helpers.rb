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

      def caching_on?
        CanTango.config.cache_engine.on? && !opts_caching_off?
      end

      def opts_caching_off?
        options[:caching] == :off
      end
    end
  end
end
