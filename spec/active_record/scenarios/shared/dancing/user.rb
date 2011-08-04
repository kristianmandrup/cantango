require 'active_record/scenarios/shared/dancing/base'

module Dancing
  module User

    include Dancing::Base

    module Active
      # the active user is used in case of masquerading to distinquish 
      # between which user is actually performing the action
      def active scope, &block
        user = active_scope_user(scope)
        ab_scope = AbilityScope.new user_ability(user)
        yield ab_scope if block
        ab_scope
      end

      private

      def active_scope_user scope
        scope_user(scope).active_user
      end
    end

    include Active

    # Example: generated from types of accounts! (see below)
    # def admin_can?(*args)
    #   current_ability(:admin).can?(*args)
    # end    
   
    def self.included(base)
    ::CanTango.users.each do |user|
      # puts "method for user: #{user}"
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

