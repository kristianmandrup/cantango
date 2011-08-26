module CanTango
  class PermitEngine < Engine
    class Finder

      # This class is used to find the right permit, possible scoped for a specific user account

      attr_reader :user_account, :name

      def initialize user_account, name
        @user_account = user_account
        @name = name
      end

      def get_permit
        raise find_error if !retrieve_permit
        retrieve_permit
      end

      protected

      def find_error
        "Permit for #{type} #{name} could not be loaded. Define either class: #{account_permit_class} or #{permit_class}"
      end

      def retrive_permit
        @found_permit ||= [account_permit(name), permit(name)].compact.first
      end

      def account_permit name
        account_permits.send(type).registered[name]
      end

      def permit name
        permits.send(type).registered[name]
      end

      def permits
        CanTango.config.permits
      end

      def account_permits
        CanTango.config.permits.account(user_account)
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
