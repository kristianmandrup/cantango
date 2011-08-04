module CanTango
  module Users
    module Masquerade

      attr_reader :masquerading

      def masquerade_as user
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
    end
  end
end
