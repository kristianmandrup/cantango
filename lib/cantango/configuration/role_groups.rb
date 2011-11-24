module CanTango
  class Configuration
    class RoleGroups < RoleRegistry
      include Singleton

      attr_writer :role_groups_system

      def role_groups_system
        @role_groups_system ||= :troles
      end

      def default_has_method
        :in_role_group?
      end

      def default_list_method
        role_groups_list_map[role_groups_system] || :role_groups_list
      end
      
      def role_groups_list_map
        @role_groups_list_map ||= {
          :troles => :role_group_list
        }
      end
    end
  end
end


