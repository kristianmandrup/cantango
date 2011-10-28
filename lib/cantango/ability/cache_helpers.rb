module CanTango
  class Ability
    module CacheHelpers
      delegate :cache_rules!, :cached_rules, :to => :cache

      def cached_rules?
        cache.key.same?(session)
      end

      def cache cache_key = :cache
        @cache ||= CanTango::Ability::Cache.new self, cache_key
      end
    end
  end
end
