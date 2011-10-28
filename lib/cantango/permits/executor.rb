# This class is responsible for executing a set of similar Permits and collecting their rule results into one rule collection
# which can be cached under some key and later reused
#
module CanTango
  module Permits
    class Executor
      include CanTango::Ability::CacheHelper

      attr_reader :ability, :permit_type, :permits

      delegate :session, :to => :ability

      def initialize ability, permit_type, permits
        @ability      = ability
        @permit_type  = permit_type
        @permits      = permits
      end

      alias_method :cache_key, :permit_type

      def rules
        @rules ||= []
      end

      def cache
        @cache ||= Cache.new self, cache_key
      end

      def execute!
        return if cached_rules?

        clear_rules!
        permit_rules

        cache_rules!
      end

      def permit_rules
        # TODO: somehow type specific caching of result of permits!
        permits.each do |permit|
          CanTango.config.permits.was_executed(permit, ability) if CanTango.debug?
          break if permit.execute == :break
        end
      end
    end
  end
end
