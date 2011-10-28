module CanTango
  class Ability
    module CacheHelpers
      delegate :cache_rules!, :cached_rules, :to => :cache

      def cached_rules?
        cache.key.same?(session)
      end

      def cache
        @cache ||= Cache.new self
      end
    end
  end
end
