module CanTango
  class PermissionEngine < Engine
    module Selector
      class RoleGroups < Base
        attr_reader :role_groups

        def initialize collector
          @role_groups = collector.role_groups_list
        end

        def relevant? role_group
          filter(role_group).valid?
        end

        def filter role_group
          CanTango::Filters::RoleGroupFilter.new role_group, role_groups
        end

        private
      end
    end
  end
end


