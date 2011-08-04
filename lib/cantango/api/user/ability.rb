module CanTango
  module Api
    module User
      module Ability
        def user_ability user, options = {}
          @current_ability ||= ::CanTango::Ability.new(user, ability_options.merge(options))
        end

        def current_ability user_type = :user
          user_meth = :"current_#{user_type}"
          return guest_user if !respond_to?(user_meth)

          user = send(user_meth)
          return guest_user if !user

          user_ability user
        end

        protected

        def guest_user
          puts "guest user"

          procedure = CanTango::Configuration.guest_user_procedure

          raise "You must set the guest_user to a Proc or lambda in CanTango::Configuration" if !procedure
          procedure.call
        end

        include CanTango::Api::Options
      end
    end
  end
end
