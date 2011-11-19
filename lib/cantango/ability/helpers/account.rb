module CanTango
  class Ability
    module Helpers
      module Account
        def user_account
          return subject.active_account if subject.respond_to? :active_account
          subject
        end
        alias_method :account, :user_account
      end
    end
  end
end
