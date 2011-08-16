module CanTango
  class PermissionEngine < Engine
    module Selector
      class RoleGroups < Base
        attr_reader :role_groups

        def initialize collector
          @role_groups = collector.role_groups_list
        end

        def valid? role_group
          return true if !role_groups_filter?
          filter(role_group).valid?
        end

        def filter role_group
          CanTango::Filters::RoleGroupFilter.new role_group, role_groups
        end

        private

        def role_groups_filter?
          CanTango.config.role_groups.filter?
        end
      end
    end
  end
end


