module CanTango
  module Api
    module User
      module Can
        include Ability
        # Example: generated from types of accounts! (see below)
        # def admin_can?(*args)
        #   current_user_ability(:admin).can?(*args)
        # end
        def self.included(base)
          ::CanTango.config.users.registered.each do |user|
            base.class_eval %{
              def #{user}_can? *args
                current_user_ability(:#{user}).can?(*args)
              end

              def #{user}_cannot? *args
                current_user_ability(:#{user}).cannot?(*args)
              end
             }
          end
        end
      end
    end
  end
end
