module CanTango
  class PermitEngine < Engine
    module Executor
      class Base < Abstract
        # execute the permit
        def execute!
          role_execution
          #role_group_execution
        end

        # only execute the permit if the user has the role of the permit or is for any role      
        def role_execution
          permit? if permit_for_user_role? || permit_for_user_group?
        end

        def permit_for_user_role?
          subject_in_role? || role == :any
        end

        def role_group_execution
          # could also use #user.is_member_of?
          permit? if permit_for_user_group?
        end

        def permit_for_user_group?
          subject_in_role_group? || false
        end

        protected

        def subject_in_role?
          return subject.send(has_role_meth, role) if subject.respond_to? has_role_meth
          return subject.send(list_role_meth, role).include? role if subject.respond_to? has_role_meth
          false
        end

        def subject_in_role_group?
          return subject.send(has_role_group_meth, role) if subject.respond_to? has_role_group_meth
          return subject.send(list_role_group_meth).include? role if subject.respond_to? list_role_group_meth
          false
        end

        include CanTango::Helpers::RoleMethods

        def role
          permit.role
        end
      end
    end
  end
end
