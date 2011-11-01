module CanTango
  class Ability
    module Executor
      include CanTango::Helpers::Debug
      include CanTango::Ability::CacheHelpers

      delegate :session, :user, :subject, :candidate, :cached?, :to => :ability

      def execute!
        return if !valid?
        start_execute
        return cached_rules if cached? && cached_rules?

        clear_rules!
        permit_rules

        cache_rules! if cached?
        end_execute
        rules
      end

      def rules
        @rules ||= []
      end

      def clear_rules!
        @rules ||= []
      end

      def permit_rules
        raise NotImplementedError
      end

      def cache
        @cache ||= CanTango::Ability::Cache.new self, :cache_key => cache_key, :key_method_names => key_method_names
      end

      def engine_name
        :permit
      end

      def valid?
        raise NotImplementedError
      end

      protected

      def start_execute
        debug "executing..."
      end

      def end_execute
        debug "DONE"
      end

      def cache_key
        raise NotImplementedError
      end

      def key_method_names
        []
      end
    end
  end
end


