module CanTango
  module Api
    module User
      module Scope

        def scope_user scope, options = {}, &block
          user = scoped_user(scope)
          ab_scope = user_ability_scope(user, options)
          yield ab_scope if block
          ab_scope
        end

        def real_user scope, options = {}, &block
          scope_user scope, options.merge(:masquerade => false), &block
        end

        protected

        def user_ability_scope user, options = {}
          CanTango::Ability::Scope.new user_ability(user, options)
        end

        def scoped_user scope
          send(:"current_#{scope}")
        end
      end
    end
  end
end
