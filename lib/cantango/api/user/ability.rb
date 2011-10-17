module CanTango
  module Api
    module User
      module Ability
        def user_ability user, options = {}
          @current_ability ||= create_ability(user, ability_options.merge(options))
        end

        def current_ability user_type = :user
          user_ability get_ability_user(user_type)
        end

        protected

        include CanTango::Api::Common

        def get_ability_user user_type
          user_meth = :"current_#{user_type}"
          return AbilityUser.guest if !respond_to?(user_meth)
          AbilityUser.resolve_user(send user_meth)
       end

        module AbilityUser
          # test if current_xxx actually returns an account and not a user instance!
          # if so call the #user method on the account
          def self.resolve_user obj
            return obj if is_user?(obj)
            return resolve_user(obj.send(:user)) if obj.respond_to? :user
            guest
          end

          def self.is_user? user
            ::CanTango.config.users.registered_class? user.class
          end

          def self.guest
            user = CanTango.config.guest.user

            raise "You must set the guest_user to a Proc or lambda in CanTango.config" if !user
            user.respond_to?(:call) ? user.call : user
          end
        end

        include CanTango::Api::Options
      end
    end
  end
end
