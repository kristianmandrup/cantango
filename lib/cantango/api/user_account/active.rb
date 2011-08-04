module CanTango
  module Api
    module UserAccount
      module Active
        include Scope
        include Ability
        # the active user is used in case of masquerading to distinquish 
        # between which user is actually performing the action
        def active_account scope, options = {}, &block
          user = active_scope_user_account(scope)
          ab_scope = CanTango::Ability::Scope.new user_account_ability(user, options)
          yield ab_scope if block
          ab_scope
        end

        protected

        def active_scope_user_account scope
          scope_user_account(scope).active_user_account
        end
      end
    end
  end
end
