module CanTango
  class PermitEngine < Engine
    class PermitFinder
      include CanTango::Helpers::Debug

      # This class is used to find the right permit, possible scoped for a specific user account
      attr_reader :user_account, :permit_type, :name

      def initialize name, permit_type, user_account = nil
        @user_account = user_account
        @permit_type = permit_type
        @name = name.to_s.underscore.to_sym
      end

      def get_permit
        raise find_error if !retrieve_permit
        retrieve_permit
      end

      protected

      def find_error
        "Permit for #{permit_type} #{name} could not be loaded. Define class: #{permit_class} (or wrapped in account scope)"
      end

      def retrieve_permit
        @found_permit ||= permits_to_try.first
      end

      def permits_to_try
        [account_permit, permit].compact
      end

        # TODO: User/Account cases should be handled somehow following is just interim measure
      def account_permit
        return nil if !registered_account? user_account.class
        found = account_permits[name]
        debug account_permit_msg(found)
        found
      rescue
        nil
      end

      def registered_account? account
        CanTango.config.user_accounts.registered_class? account
      end

      def account_permit_msg found
        found.nil? ? "no account permits found for #{name}" : "account permits registered for name: #{name} -> #{found}"
      end

      def permit
        found = registered_permits.registered_for permit_type, name
        debug permit_msg(found)
        found
      end

      def permit_msg found
        found.nil? ? "no permits found for #{name}" : "permits registered for name: #{name} -> #{found}"
      end

      def account_permits
        account_permits_for_account.registered_for(permit_type)
      end

      def permits
        registered_permits.registered_for(permit_type)
      end

      def registered_permits
        CanTango.config.permits
      end

      def account_permits_for_account
        registered_permits.send(account)
      end

      def account
        user_account.class.name.underscore
      end

      # this is used to namespace role permits for a specific type of user account
      # this allows role permits to be defined differently for each user account (and hence sub application) if need be
      # otherwise it will fall back to the generic role permit (the one which is not wrapped in a user account namespace)
      def account_permit_class
        [account_permit_ns , permit_class].join('::')
      end

      def account_permit_ns
        "#{user_account.class}Permits"
      end

      def permit_class
        "#{name.to_s.camelize}Permit"
      end
    end
  end
end
