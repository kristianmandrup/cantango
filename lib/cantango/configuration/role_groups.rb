module CanTango
  class Configuration
    class RoleGroups < RoleRegistry
      include Singleton

      def role_group_system= name
        raise ArgumentError, "Must be a label" if !name.kind_of_label?
        @role_group_system = name.to_sym
      end

      def role_groups_list_map= role_systems_hash
        raise ArgumentError, "Must be a hash fx :troles => :role_list, was: #{role_systems_hash}" if !role_systems_hash.kind_of?(Hash)
        @role_groups_list_map = role_systems_hash
      end

      def role_group_system
        @role_group_system ||= :troles
      end

      def add_role_group_system role_system_hash
        raise ArgumentError, "Must be a hash fx :troles => :role_list, was: #{role_system_hash}" if !role_system_hash.kind_of?(Hash)
        role_groups_list_map.merge! role_system
      end

      def default_has_method
        :in_role_group?
      end

      def default_list_method
        role_groups_list_map[role_group_system] || :role_groups_list
      end
      
      def role_groups_list_map
        @role_groups_list_map ||= {
          :troles => :role_group_list
        }
      end
    end
  end
end


