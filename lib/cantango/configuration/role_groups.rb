module CanTango
  class Configuration
    class RoleGroups
      include Singleton

      attr_writer :default, :role_groups

      def role_groups
        @role_groups || default
      end

      def default
        @default ||= []
      end
    end
  end
end


