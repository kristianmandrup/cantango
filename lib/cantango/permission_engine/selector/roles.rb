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
          roles.include? permission.to_sym
        end
      end
    end
  end
end



