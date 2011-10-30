# This class is responsible for executing a set of similar Permits and collecting their rule results into one rule collection
# which can be cached under some key and later reused
#
module CanTango
  class UserAcEngine < Engine
    class Executor
      include CanTango::Ability::CacheHelpers

      attr_reader :ability, :permissions

      delegate :session, :user, :subject, :cached?, :to => :ability

      def initialize ability, permissions
        @ability        = ability
        @permissions    = permissions
      end

      def cache_key
        :user_ac
      end

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
        return cached_rules if cached_rules?

        clear_rules!
        permit_rules

        cache_rules!
        rules
      end

      def permit_rules
        permissions.each do |permission|
          ability.can permission.action.to_sym, permission.thing_type.constantize do |thing|
            thing.nil? || permission.thing_id.nil? || permission.thing_id == thing.id
          end
        end
      end

      protected

      def key_method_names
        [:permissions_hash]
      end
    end
  end
end

