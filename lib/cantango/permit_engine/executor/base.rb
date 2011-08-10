module CanTango
  module PermitEngine
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
          subject.has_role?(role) || role == :any
        end

        def role_group_execution
          # could also use #user.is_member_of?
          permit? if permit_for_user_group?
        end

        def permit_for_user_group?
          subject.is_in_group?(role) if subject.respond_to? :is_in_group?
          subject.in_role_group?(role) if subject.respond_to? :in_role_group?
          false
        end

        protected

        def role
          permit.role
        end
      end
    end

  end
end
