require 'active_record/scenarios/shared/dancing/base'

module Dancing
  module User
    include Dancing::Base

    # Example: generated from types of accounts! (see below)
    # def admin_can?(*args)
    #   current_ability(:admin).can?(*args)
    # end

    def self.included(base)
      ::CanTango.config.users.registered.each do |user|
        class_eval %{
          def #{user}_can? *args
            current_ability(:#{user}).can?(*args)
          end
        }
      end
    end

    def user_scope scope, &block
      su = scope_user(scope)
      yield su if block
      su
    end

    protected

    def user_ability user
      @current_ability ||= ::CanTango::Ability.new(user)
    end

    def current_ability user = :user
      user_ability send(:"current_#{user}")
    end
  end
end

