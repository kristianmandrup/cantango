module CanTango
  module Api
    module User
      module Ability
        def user_ability user, options = {}
          @current_ability ||= ::CanTango::Ability.new(user, ability_options.merge(options))
        end

        def current_ability user = :user 
          user_ability send(:"current_#{user}")
        end

        protected

        include CanTango::Api::Options
      end
    end
  end
end
