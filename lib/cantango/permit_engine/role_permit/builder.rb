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
            (permits << create_permit(role)) if valid?(role.to_sym)
            permits
          end.compact
        end

        def finder
          CanTango::PermitEngine::RolePermit::Finder
        end

        protected

        def valid? role
          return false if not_only_role?(role)
          !excluded? role
        end

        def not_only_role? role
          !only_roles.empty? && !only_roles.include?(role)
        end

        def excluded? role
          excluded_roles.include? role
        end

        def only_roles
          CanTango.config.roles.onlies
        end

        def excluded_roles
          CanTango.config.roles.excluded
        end
      end
    end
  end
end
