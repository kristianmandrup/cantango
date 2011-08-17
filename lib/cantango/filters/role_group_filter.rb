module CanTango
  module Filters
    class RoleGroupFilter < Filter
      alias_method :role_group, :item

      def initialize role_group, role_groups = nil
        super      
      end

      def not_only?
        !only_role_groups.empty? && !only_role_groups.include?(role_group)
      end

      def excluded?
        !excluded_role_groups.empty? && excluded_role_groups.include?(role_group)
      end

      def only_role_groups
        CanTango.config.role_groups.onlies
      end

      def excluded_role_groups
        CanTango.config.role_groups.excluded
      end
    end
  end
end

