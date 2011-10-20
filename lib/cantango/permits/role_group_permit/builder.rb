module CanTango
  module Permits
    class RoleGroupPermit < CanTango::Permit

      class Builder < CanTango::PermitEngine::Builder::Base
        #class NoAvailableRoleGroups < StandardError; end

        # builds a list of Permits for each role group of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role group permits built for this ability
        def build
          matching_permits = matching_role_groups(roles).inject([]) do |permits, role_group|
            puts "Building RoleGroupPermit for #{role_group}" if CanTango.debug?
            (permits << create_permit(role_group)) if valid?(role_group)
            permits
          end.compact

          if matching_permits.empty?
            puts "Not building any RoleGroupPermits since no role groups are roles that are members of a role group could be found for the permission candidate" if CanTango.debug?
            return []
          end
       end

        def valid? role_group
          return true if !role_groups_filter?
          filter(role_group).valid?
        end

        def filter role_group
          CanTango::Filters::RoleGroupFilter.new role_group
        end

        private

        def matching_role_groups roles
          role_groups | matching_role_groups_for(roles)
        end

        # will also run role_groups for which any role of the candidate is a member
        # so if the candidate is a user and the user has a :trustee role and this role is part of the :trust role group,
        # then the :trust role group permit will be run!
        # Thus if the candidate has a particular role group or just has a role belonging to that role group, the permit
        # for that role group will be run
        def matching_role_groups_for roles
          roles.inject([]) do |groups, role|
            groups << subject.role_groups_for(role) if subject.respond_to?(:role_groups_for)
            groups
          end.flatten.compact.uniq
        end

        def role_groups_filter?
          CanTango.config.role_groups.filter?
        end
      end
    end
  end
end
