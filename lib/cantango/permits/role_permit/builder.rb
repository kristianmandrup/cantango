module CanTango
  module Permits
    class RolePermit < CanTango::Permit
      class Builder < CanTango::PermitEngine::Builder::Base
        # class NoAvailableRoles < StandardError; end

        # builds a list of Permits for each role of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
        def build
          # raise NoAvailableRoles, "no available roles are defined" if available_roles.empty?
          roles.inject([]) do |permits, role|
            (permits << create_permit(role)) if valid?(role.to_sym)
            permits
          end.compact
        end

        protected

        def valid? role
          filter(role).valid?
        end

        def filter role
          CanTango::Filters::RoleFilter.new role
        end

      end
    end
  end
end
