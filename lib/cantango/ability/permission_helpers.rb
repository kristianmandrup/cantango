module CanTango
  class Ability
    module PermissionHelpers
      protected

      def permissions?
        config.permissions.on?
      end
    end
  end
end
 
