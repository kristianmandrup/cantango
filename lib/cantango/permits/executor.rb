# This class is responsible for executing a set of similar Permits and collecting their rule results into one rule collection
# which can be cached under some key and later reused
#
module CanTango
  module Permits
    class Executor
      include CanTango::Ability::Executor

      attr_reader :ability, :permit_type, :permits

      def initialize ability, permit_type, permits
        @ability      = ability
        @permit_type  = permit_type
        @permits      = permits
      end

      alias_method :cache_key, :permit_type

      def cache
        @cache ||= CanTango::Ability::Cache.new self, :cache_key => cache_key, :key_method_names => key_method_names
      end

      def permit_rules
        # TODO: somehow type specific caching of result of permits!
        permits.each do |permit|
          CanTango.config.permits.was_executed(permit, ability) if CanTango.debug?
          break if permit.execute == :break
        end
      end

      protected

      def valid?
        true
      end

      def start_execute
        debug "Execute #{permit_type} permits"
      end

      def end_execute
        debug "Done #{permit_type} permits"
      end

      def key_method_names
        case permit_type
        when :role
          [roles_list_meth]
        when :role_group
          [role_groups_list_meth]
        else
          []
        end
      end
    end
  end
end
