module CanTango
  class Ability
    module PermissionHelpers
      def permissions
        permission_factory.build!
      end

      protected

      def permission_factory
        @permission_factory ||= CanTango::PermissionEngine::Factory.new self
      end

      def permissions?
        config.permissions.on?
      end
    end
  end
end
 
