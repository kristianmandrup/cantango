module CanTango
  module Api
    module UserAccount
      module Scope
        protected

        def scope_acount scope
          send(:"current_#{scope}_account")
        end

        protected

        def user_account_scope scope, &block
          su = scope_user_account(scope)
          yield su if block
          su
        end
      end
    end
  end
end
