module CanTango
  class PermitEngine < Engine
    module Builder
      class CreatePermitError < StandardError; end;

      class Base
        include CanTango::Helpers::Debug

        attr_accessor :ability

        # creates the factory for the ability
        # note that the ability contains the roles and role groups of the user (or account)
        # @param [Permits::Ability] the ability
        def initialize ability, finder
          @ability = ability
          @finder = finder
        end

        # should be implemented by builder subclass!
        def build
          raise NotImplementedError
        end

        protected

        # Tries to create a new permit
        # If no permit Class can be found, it should return nil
        # @param [Symbol] the name
        # @return the permit Class or nil if not found
        def create_permit
          begin
            permit_class.new ability
          rescue RuntimeError => e
            # puts "Error instantiating Permit instance for #{name}, cause: #{e}" if CanTango.debug?
            nil
          end
        end

        def permit_class
          finder.get_permit
        end

        # delegate to ability
        [:options, :subject, :user, :user_account].each do |name|
          define_method name do
            ability.send(name)
          end
        end
=begin
        def available_role_groups
          CanTango.config.role_groups
        end

        def available_roles
          CanTango.config.roles
        end
=end
      end
    end
  end
end
