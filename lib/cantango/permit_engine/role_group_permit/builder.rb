module CanTango
  module PermitEngine
    class RoleGroupPermit < CanTango::PermitEngine::Permit

      class Builder < CanTango::PermitEngine::Builder::Base
        #class NoAvailableRoleGroups < StandardError; end

        # builds a list of Permits for each role group of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role group permits built for this ability
        def build
          # raise NoAvailableRoleGroups, "no available roles groups are defined" if available_role_groups.empty?
          role_groups.inject([]) do |permits, role_group|
            (permits << create_permit(role_group)) if valid? role_group
            permits
          end.compact
        end

        protected

        def valid? role_group
          !excluded_role_groups.include?(role_group.to_sym)
        end

        def excluded_role_groups
          CanTango.config.role_groups.excluded
        end

        def finder
          CanTango::PermitEngine::RoleGroupPermit::Finder
        end
      end
    end
  end
end
