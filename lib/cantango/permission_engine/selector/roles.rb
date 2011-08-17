module CanTango
  class PermissionEngine < Engine
    module Selector
      class Roles < Base
        attr_reader :roles

        def initialize subject
          @roles = subject.roles_list
        end

        protected

        def relevant? role
          filter(role).valid?
        end

        def filter role
          CanTango::Filters::RoleFilter.new role, roles
        end

        private

      end
    end
  end
end



