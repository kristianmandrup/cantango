module CanTango
  module User
    module Active
      def active_user
        session[:active_user]
      end

      def active_user= user
        session[:active_user] = user
      end
    end
  end
end