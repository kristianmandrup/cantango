module CanTango
  class Ability
    module CachedExecutor
      include CanTango::Ability::CacheHelpers

      def cached?
        @rules = cached_rules if cached_rules? && caching_on?
      end

     def cache
        @cache ||= CanTango::Ability::Cache.new self, :cache_key => cache_key, :key_method_names => key_method_names
      end

      protected

      def start_execute
        debug "executing cached..."
      end

      def end_execute
        cache_rules! if caching_on?
        debug "DONE"
      end
    end
  end
end
