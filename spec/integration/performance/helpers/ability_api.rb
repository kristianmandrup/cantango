Stamper.scope :call_on_ability => "Call on Ability" do |stan|
  stan.msg :caching_done      => "Caching finished"
end

module CanTango
  module Api
    module User
      module Ability
        def user_ability user, options = {}
          stamper(:call_on_ability) { 
            @current_ability ||= ::CanTango::Ability.new(user, ability_options.merge(options)) 
          }
          @current_ability
        end

        def current_ability user_type = :user
          user_ability get_ability_user(user_type)

        end

        protected

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
