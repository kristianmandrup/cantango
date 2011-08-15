module CanTango
  module PermissionEngine
    module Selector
      class Roles < Base
        attr_reader :roles

        def initialize subject
          @roles = subject.roles_list
        end

        protected

        def valid? role
          return true if !roles_filter?
          filter(role).valid?
        end

        def filter role
          CanTango::Filters::RoleFilter.new role, roles
        end

        private

        def roles_filter?
          CanTango.config.roles.filter?
        end
      end
    end
  end
end



