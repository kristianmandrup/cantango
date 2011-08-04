module CanTango
  module Api
    module User
      module Scope

        protected

        def scope_user scope
          send(:"current_#{scope}")
        end

        def user_scope scope, &block
          su = scope_user(scope) 
          yield su if block
          su
        end
      end
    end
  end
end
