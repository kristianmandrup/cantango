module CanTango
  class Configuration
    class Roles < RoleRegistry
      include Singleton

      def role_system= name
        raise ArgumentError, "Must be a label" if !name.kind_of_label?
        @role_system = name.to_sym
      end

      def roles_list_map= role_systems_hash
        raise ArgumentError, "Must be a hash fx :troles => :role_list, was: #{role_systems_hash}" if !role_systems_hash.kind_of?(Hash)
        @roles_list_map = role_systems_hash
      end

      def role_system
        @role_system ||= :simple_roles
      end

      def add_role_system role_system_hash
        raise ArgumentError, "Must be a hash fx :troles => :role_list, was: #{role_system_hash}" if !role_system_hash.kind_of?(Hash)
        roles_list_map.merge! role_system
      end

      def default_has_method
        role_system_methods[:list] || :has_role?
      end

      def default_list_method
        role_system_methods[:list] || :roles_list
      end
      
      def role_system_methods
        roles_list_map[role_system] || {}
      end
      
      def roles_list_map
        @roles_list_map ||= {
          :troles       => {:list => :role_list},
          :simple_roles => {:list => :roles_list}
        }
      end
    end
  end
end
