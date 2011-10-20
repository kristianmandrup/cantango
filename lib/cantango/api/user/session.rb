module CanTango
  module Api
    module User
      module Session
        # Example: generated from types of accounts! (see below)
        # def admin_can?(*args)
        #   current_ability(:admin).can?(*args)
        # end

        def self.included(base)
          ::CanTango.config.users.registered.each do |user|
            base.class_eval %{
              def session_#{user}
                current_#{user} if respond_to? :current_#{user}
                guest_user
              end
            }
          end
        end

        # give me any logged in user or the guest user
        def any_user *types
          types = types.flatten.select_labels.map(&:to_sym)
          c_user = ::CanTango.config.users.registered.each do |user|
            meth = :"current_#{user}"
            send(meth) if respond_to?(meth) && (types.empty? || types.include?(user))
          end.compact.first
          c_user || guest_user
        end

        def guest_user
          CanTango.config.guest.user
        end
      end
    end
  end
end
