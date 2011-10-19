module CanTango
  module Api
    module UserAccount
      module Session
        def self.included(base)
          ::CanTango.config.user_accounts.registered.each do |type|
            base.class_eval %{
              def session_#{type}_account
                current_#{type}_account if respond_to? :current_#{type}_account
                guest_account
              end
            }
          end
        end

        # give me any logged in user or the guest user
        def any_account *types
          types = types.flatten.select_labels.map(&:to_sym)
          c_account = ::CanTango.config.user_accounts.registered.each do |type|
            meth = :"current_#{type}_account"
            send(meth) if respond_to?(meth) && (types.empty? || types.include?(user))
          end.compact.first
          c_account || guest_account
        end

        def guest_account
          CanTango.config.guest.account
        end
      end
    end
  end
end

