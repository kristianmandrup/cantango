module CanTango
  class Configuration
    class Guest
      include Singleton

      attr_reader :user_procedure, :account_procedure

      def user procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @user_procedure = procedure
      end

      def account procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @account_procedure = procedure
      end
    end
  end
end
 
