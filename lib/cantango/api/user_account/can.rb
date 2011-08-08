module CanTango
  module Api
    module UserAccount
      module Can
        include Ability
        # Example: generated from types of accounts! (see below)
        # def admin_account_can?(*args)
        #   current_account_ability(:admin).can?(*args)
        # end
        def self.included(base)
          ::CanTango.config.user_accounts.registered.each do |account|
            base.class_eval %{
              def #{account}_account_can? *args
                current_account_ability(:#{account}).can?(*args)
              end
            }
          end
        end
      end
    end
  end
end
