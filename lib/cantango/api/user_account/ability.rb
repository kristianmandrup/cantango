module CanTango
  module Api
    module UserAccount
      module Ability
        def user_account_ability user_account, options = {}
          @current_ability ||= ::CanTango::Ability.new(user_account, ability_options.merge(options))
        end

        def current_account_ability user_type = :user
          account_meth = :"current_#{user_type}_account"
          return guest_user if !respond_to?(account_meth)

          user_account = send(account_meth)
          return guest_user_account if !user_account

          user_account_ability user_account
        end

        protected

        def guest_user
          procedure = CanTango::Configuration.guest_account_procedure

          raise "You must set the guest_account to a Proc or lambda in CanTango::Configuration" if !procedure
          procedure.call
        end

        include CanTango::Api::Options
      end
    end
  end
end
