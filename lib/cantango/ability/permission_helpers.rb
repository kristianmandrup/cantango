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

      def permission_engine?
        CanTango.config.permissions.on?
      end
    end
  end
end
 
