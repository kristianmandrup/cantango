module CanTango
  module Users
    module Masquerade
      attr_reader :masquerading

      def masquerade_as user
        raise "Must be a registered type of user, was: #{user}" if !user? user
        @masquerading = true
        user = user.kind_of?(String) ? ::User.find(user) : user
        @active_user = user
      end

      def stop_masquerade
        @active_user, @masquerading = nil, nil
      end

      def masquerading?
        !@masquerading.nil?
      end
      
      private
      
      def user? user
        CanTango.config.users.registered_value? user
      end
    end
  end
end
