module CanTango
  module PermissionEngine
    module Selector
      class Roles < Base
        attr_reader :roles

        def initialize subject
          @roles = subject.roles_list
        end

        # TODO: Add roles filter
        def valid? permission
          valid_roles.include?(permission.to_sym)
        end

        def valid_roles
          roles - CanTango.config.roles.excluded
        end
      end
    end
  end
end



