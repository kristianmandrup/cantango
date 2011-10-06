module CanTango
  module Permits
    class RoleGroupPermit < CanTango::Permit

      class Builder < CanTango::PermitEngine::Builder::Base
        #class NoAvailableRoleGroups < StandardError; end

        # builds a list of Permits for each role group of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role group permits built for this ability
        def build
          if roles.empty?
            puts "Not building any RoleGroupPermit" if CanTango.debug?
            return [] if role_groups.empty?
          end
      
          role_groups.inject([]) do |permits, role_group|
            puts "Building RoleGroupPermit for #{role_group}" if CanTango.debug?
            (permits << create_permit(role_group)) if valid?(role_group)
            permits
          end.compact
        end

        def valid? role_group
          return true if !role_groups_filter?
          filter(role_group).valid?
        end

        def filter role_group
          CanTango::Filters::RoleGroupFilter.new role_group
        end

        private

        def role_groups_filter?
          CanTango.config.role_groups.filter?
        end
      end
    end
  end
end
