module CanTango
  class Configuration
    class Guest
      include Singleton

      def get_user
        @user ||= User.guest if default_user?
      end

      def get_account
        @account ||= UserAccount.guest if default_user_account?
      end

      def user procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @user = procedure
      end

      def account procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @account = procedure
      end

      protected

      def default_user?
        defined?(User) && User.respond_to?(:guest)
      end

      def default_user_account?
        defined?(UserAccount) && UserAccount.respond_to?(:guest)
      end
    end
  end
end
 
