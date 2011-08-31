module CanTango
  class Configuration
    class Roles < RoleRegistry
      include Singleton

      def default_has_method
        :has_role?
      end

      def default_list_method
        :roles_list
      end
    end
  end
end



