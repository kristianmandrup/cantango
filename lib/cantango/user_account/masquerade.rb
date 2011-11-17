module CanTango
  module UserAccount
    module Masquerade
      attr_reader :masquerading

      def masquerade_as account
        raise "Must be a registered type of account, was: #{account}" if !account? account
        @masquerading = true
        @active_account = account
      end

      def stop_masquerade
        @active_account, @masquerading = nil, nil
      end

      def masquerading?
        !@masquerading.nil?
      end
      
      private
      
      def account? account
        CanTango.config.user_accounts.registered_value? account
      end
    end
  end
end
