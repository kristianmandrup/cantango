module CanTango
  class PermitEngine < Engine
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

        def finder
          ns::Finder
        end

        def ns
          self.class.to_s.gsub(/::Builder/, '').constantize
        end

        # Tries to create a new permit for the given role
        # If no permit Class can be found, it should return nil
        # @param [Symbol] the name
        # @return the permit Class or nil if not found
        def create_permit name
          begin
            permit_clazz(name).new ability
          rescue RuntimeError => e
            #raise "Error instantiating Permit instance for role #{role}, cause #{e}"
            nil
          end
        end

        def permit_clazz name
          finder.new(subject, name).get_permit
        end

        # delegate to ability
        [:options, :role_groups, :roles, :subject, :user, :user_account].each do |name|
          define_method name do
            ability.send(name)
          end
        end

        def available_role_groups
          CanTango.config.role_groups
        end

        def available_roles
          CanTango.config.roles
        end
      end
    end
  end
end
