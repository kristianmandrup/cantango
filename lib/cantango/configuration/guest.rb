module CanTango
  class Configuration
    class Guest
      include Singleton

      def user_proc
        @user ||= base_user_class.guest if default_user?
      end

      def account_proc
        @account ||= base_account_class.guest if default_user_account?
      end

      def user procedure
        # raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @user = procedure
      end

      def account procedure
        # raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @account = procedure
      end

      # protected

      def default_user?
        has_guest? base_user_class
      end

      def default_user_account?
        has_guest? base_account_class
      end

      protected

      def has_guest? clazz
        clazz && defined?(clazz) && clazz.respond_to?(:guest)
      end

      def base_user_class
        CanTango::Configuration.user.base_class
      end

      def base_account_class
        CanTango::Configuration.user.base_class
      end
    end
  end
end
 
