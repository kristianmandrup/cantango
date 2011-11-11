module CanTango
  module Permits
    class UserTypePermitBuilder < CanTango::PermitEngine::PermitBuilder
      # class NoAvailableRoles < StandardError; end

      # builds a list of Permits for each role of the current ability user (or account)
      # @return [Array<Permit::Base>] the role permits built for this ability
      def build
        puts debug_msg if CanTango.debug?
        [permit].compact
      end

      protected

      def debug_msg
        permit ? "Building UserPermit for #{user}, permit: #{permit}" : "Not building any UserPermit"
      end

      def permit
        @permit ||= create_permit permit_type
      end
    end
  end
end

