module CanTango
  class Ability
    module CacheHelpers
      delegate :cache_rules!, :cached_rules, :cached_rules?, :to => :cache

      def cache options = {}
        @cache ||= CanTango::Ability::Cache.new self, options
      end
    end
  end
end
