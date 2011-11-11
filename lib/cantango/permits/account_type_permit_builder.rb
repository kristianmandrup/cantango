module CanTango
  module Permits
    class AccountTypePermitBuilder < CanTango::PermitEngine::PermitBuilder
      # class NoAvailableRoles < StandardError; end

      # builds a list of Permits for each role of the current ability user (or account)
      # @return [Array<RoleGroupPermit::Base>] the role permits built for this ability
      def build
        return [] if !user_account
        puts debug_msg if CanTango.debug?
        [permit].compact
      end

      def name
        :account
      end

      protected

      def debug_msg
        permit ? "Building AccountPermit for #{user_account}, permit: #{permit}" : "Not building any AccountPermit"
      end

      def permit
        create_permit(user_account.class.to_s)
      end
    end
  end
end

