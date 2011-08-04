module CanTango
  module Api
    module UserAccount
      module Ability
        def user_account_ability user_account, options = {}
          @current_ability ||= ::CanTango::Ability.new(user_account, ability_options.merge(options))
        end

        def current_account_ability user_type = :user
          user_meth = :"current_#{user_type}_account"
          return guest_user if !respond_to?(user_meth)
          user_account = send(user_meth)
          return guest_user_account if !user
          user_account_ability user_account
        end

        protected

        def guest_user
          CanTango::Configuration.guest_account_procedure.call
        end

        include CanTango::Api::Options
      end
    end
  end
end
