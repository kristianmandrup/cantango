module CanTango
  module PermissionEngine
    module Selector
      class RoleGroups < Base
        attr_reader :role_groups

        def initialize collector
          @role_groups = collector.role_groups_list
        end

        def valid? permission
          role_groups.include? permission.to_sym
        end
      end
    end
  end
end


