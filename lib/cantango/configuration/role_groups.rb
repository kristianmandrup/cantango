module CanTango
  class Configuration
    class RoleGroups < RoleRegistry
      def default_has_method
        :in_role_group?
      end

      def default_list_method
        :role_groups_list
      end
    end
  end
end


