module CanTango
  module Permits
    class UserPermit < CanTango::Permit
      class Builder < CanTango::PermitEngine::Builder::Base
        # class NoAvailableRoles < StandardError; end

        # builds a list of Permits for each role of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
        def build
          # raise NoAvailableRoles, "no available roles are defined" if available_roles.empty?
          [] << create_permit(user.class.to_s)
        end
      end
    end
  end
end

