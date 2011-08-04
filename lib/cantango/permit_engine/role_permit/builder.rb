module CanTango
  module PermitEngine
    class RolePermit < CanTango::PermitEngine::Permit
      class Builder < CanTango::PermitEngine::Builder::Base
        # class NoAvailableRoles < StandardError; end

        # builds a list of Permits for each role of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
        def build
          # raise NoAvailableRoles, "no available roles are defined" if available_roles.empty?
          roles.inject([]) do |permits, role|
            permits << create_permit(role)
          end.compact
        end
      
        def finder
          CanTango::PermitEngine::RolePermit::Finder
        end      
      end
    end
  end
end
