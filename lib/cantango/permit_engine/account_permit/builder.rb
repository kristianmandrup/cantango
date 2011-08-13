module CanTango
  module PermitEngine
    class AccountPermit < CanTango::PermitEngine::Permit
      class Builder < CanTango::PermitEngine::Builder::Base
        # class NoAvailableRoles < StandardError; end

        # builds a list of Permits for each role of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
        def build
          return [] if !user_account
          # raise NoAvailableRoles, "no available roles are defined" if available_roles.empty?
          [] << create_permit(user_account.class.to_s)
        end

        def finder
          CanTango::PermitEngine::AccountPermit::Finder
        end
      end
    end
  end
end

