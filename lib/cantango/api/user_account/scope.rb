module CanTango
  module Api
    module UserAccount
      module Scope

        def account_scope scope, options = {}, &block
          account = scoped_account(scope)
          ab_scope = account_ability_scope(account, options)
          yield ab_scope if block
          ab_scope
        end

        def as_real_account scope, options = {}, &block
          scope_account scope, options.merge(:masquerade => false), &block
        end

        protected

        def account_ability_scope account, options = {}
          CanTango::Ability::Scope.new user_account_ability(account, options)
        end

        def scoped_acount scope
          send(:"current_#{scope}_account")
        end
      end
    end
  end
end
