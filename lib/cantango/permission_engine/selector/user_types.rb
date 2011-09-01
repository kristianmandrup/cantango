module CanTango
  class PermissionEngine < Engine
    module Selector
      class UserTypes < Base
        attr_reader :user_type

        def initialize subject
          @user_type = subject.user.class.to_s.underscore
        end

        protected

        def relevant? user_type
          self.user_type == user_type
        end
      end
    end
  end
end




