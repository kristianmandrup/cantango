module CanTango
  module Filters
    class RoleFilter < Filter
      alias_method :role, :item

      def initialize role, roles = nil
        super
      end

      def not_only?
        !only_roles.empty? && !only_roles.include?(role)
      end

      def excluded?
        !excluded_roles.empty? && excluded_roles.include?(role)
      end

      def only_roles
        CanTango.config.roles.onlies
      end

      def excluded_roles
        CanTango.config.roles.excluded
      end
    end
  end
end


