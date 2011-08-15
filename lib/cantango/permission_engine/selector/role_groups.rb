module CanTango
  module PermissionEngine
    module Selector
      class RoleGroups < Base
        attr_reader :role_groups

        def initialize collector
          @role_groups = collector.role_groups_list
        end

        # TODO: Add roles filter
        def valid? permission
          valid_role_groups.include? permission.to_sym
        end

        def valid_role_groups
          role_groups - CanTango.config.role_groups.excluded
        end
      end
    end
  end
end


