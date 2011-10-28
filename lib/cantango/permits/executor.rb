# This class is responsible for executing a set of similar Permits and collecting their rule results into one rule collection
# which can be cached under some key and later reused
#
module CanTango
  module Permits
    class Executor
      include CanTango::Ability::CacheHelpers

      attr_reader :ability, :permit_type, :permits

      delegate :session, :user, :subject, :to => :ability

      def initialize ability, permit_type, permits
        @ability      = ability
        @permit_type  = permit_type
        @permits      = permits
      end

      alias_method :cache_key, :permit_type

      def rules
        @rules ||= []
      end

      def clear_rules!
        @rules ||= []
      end

      def cache
        @cache ||= CanTango::Ability::Cache.new self, :cache_key => cache_key, :key_method_names => key_method_names
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

      protected

      def key_method_names
        case permit_type
        when :role
          [:roles_list]
        when :role_group
          [:role_groups_list]
        else
          []
        end
      end
    end
  end
end
