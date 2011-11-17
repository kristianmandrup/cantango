module CanTango
  module UserAccount
    module Active
      def active_account
        session[:active_account]
      end

      def active_account= account
        session[:active_account] = account
      end
    end
  end
end