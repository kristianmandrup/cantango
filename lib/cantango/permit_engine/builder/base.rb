module CanTango
  module PermitEngine
    module Builder
      class Base
        attr_accessor :ability

        # creates the factory for the ability
        # note that the ability contains the roles and role groups of the user (or account)
        # @param [Permits::Ability] the ability
        def initialize ability
          @ability = ability
        end

        protected

        # Tries to create a new permit for the given role
        # If no permit Class can be found, it should return nil
        # @param [Symbol] the role
        # @return the permit Class or nil if not found
        def create_permit role
          begin
            permit_clazz(role).new ability
          rescue RuntimeError => e
            #raise "Error instantiating Permit instance for role #{role}, cause #{e}"
            nil
          end
        end

        protected

        def options
          ability.options
        end

        def permit_clazz name
          finder.new(subject, name).get_permit
        end

        def role_groups
          ability.role_groups
        end

        def roles
          ability.roles
        end

        def subject
          ability.subject
        end

        def available_role_groups
          CanTango::Configuration.role_groups
        end

        def available_roles
          CanTango::Configuration.roles
        end
      end
    end
  end
end
