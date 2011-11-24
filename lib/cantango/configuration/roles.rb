module CanTango
  class Configuration
    class Roles < RoleRegistry
      include Singleton

      attr_writer :roles_system

      def roles_system
        @roles_system ||= :troles
      end

      def default_has_method
        :has_role?
      end

      def default_list_method
        role_list_map[roles_system] || :roles_list
      end
      
      def role_list_map
        @role_list_map ||= {
          :troles => :role_list
        }
      end
    end
  end
end



