module CanTango
  module Api
    module UserAccount
      module Ability
        def user_account_ability user_account, options = {}
          @current_ability ||= ::CanTango::Ability.new(user_account, ability_options.merge(options))
        end

        def current_account_ability name = :user 
          user_account_ability send(:"current_#{name}_account")
        end

        protected

        include CanTango::Api::Options
      end
    end
  end
end
