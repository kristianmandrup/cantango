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

          user = send user_meth
          user ? user : AbilityUser.guest
        end

        module AbilityUser
          def self.guest
            user = CanTango::Configuration.guest.user

            raise "You must set the guest_user to a Proc or lambda in CanTango::Configuration" if !user
            procedure.respond_to?(:call) ? user.call : user
          end
        end

        include CanTango::Api::Options
      end
    end
  end
end
