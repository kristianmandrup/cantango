module CanTango
  module Api
    module UserAccount
      module Ability
        def user_account_ability user_account, options = {}
          @current_ability ||= create_ability(user_account, ability_options.merge(options))
        end

        def current_account_ability user_type = :user
          account_meth = :"current_#{user_type}_account"
          return guest_user_account if !respond_to?(account_meth)

          user_account = send(account_meth)
          return guest_user_account if !user_account

          user_account_ability user_account
        end

        protected

        include CanTango::Api::Common

        def get_ability_user_acount user_type
          user_account_meth = :"current_#{user_type}_account"
          return AbilityAccount.guest if !respond_to?(user_account_meth)

          user_account = send user_account_meth
          user_account ? user_account : AbilityAccount.guest
        end

        module AbilityAccount
          def self.guest
            account = CanTango::Configuration.guest.account

            raise "You must set the guest_account to a Proc or lambda in CanTango::Configuration" if !account
            account.respond_to?(:call) ? account.call : account
          end
        end

        include CanTango::Api::Options
      end
    end
  end
end
