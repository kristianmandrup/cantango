module CanTango
  module Api
    module User
      module Active
        include Scope
        include Ability

        # the active user is used in case of masquerading to distinquish 
        # between which user is actually performing the action
        def active_user scope, options = {}, &block
          user = active_scope_user(scope)
          ab_scope = CanTango::Ability::Scope.new user_ability(user, options)
          yield ab_scope if block
          ab_scope
        end

        protected

       def active_scope_user scope
          scope_user(scope).active_user
        end
      end
    end
  end
end

