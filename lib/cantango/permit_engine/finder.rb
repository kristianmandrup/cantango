module CanTango
  class PermitEngine < Engine
    class Finder
      include ClassExt

      # This class is used to find the right permit, possible scoped for a specific user account

      attr_reader :user_account, :name

      def initialize user_account, name
        @user_account = user_account
        @name = name
      end

      def get_permit
        begin
          find_first_class account_permit_class, permit_class
        rescue
          raise "Permit for #{type} #{name} could not be loaded. Define either class: #{account_permit_class} or #{permit_class}"
        end
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
