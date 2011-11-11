module CanTango
  class PermissionEngine < Engine
    module Selector
      class AccountTypes < Base
        attr_reader :account_type

        def initialize subject
          @account_type = subject.account.class.to_s.underscore
        end

        protected

        def relevant? account_type
          self.account_type == account_type
        end
      end
    end
  end
end





