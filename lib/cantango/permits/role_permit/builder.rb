module CanTango
  module Permits
    class RolePermit < CanTango::Permit
      class Builder < CanTango::PermitEngine::Builder::Base
        # builds a list of Permits for each role of the current ability user (or account)
        # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
        def build
          if roles.empty?
            puts "Not building any RolePermit" if CanTango.debug?
            return [] if roles.empty?
          end
          roles.inject([]) do |permits, role|
            puts "Building RolePermit for #{role}" if CanTango.debug?
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
