require 'active_record/scenarios/shared/dancing/base'

module Dancing
  module UserAccount

    include Dancing::Base

    # the active user is used in case of masquerading to distinquish 
    # between which user is actually performing the action
    def active scope, &block
      user = active_scope_user(scope)
      ab_scope = AbilityScope.new user_ability(user)
      yield ab_scope if block
      ab_scope
    end

    def scope_user scope
      send(:"current_#{scope}")
    end

    def scope_user_account scope
      send(:"current_#{scope}_account")
    end

    def active_scope_user scope
      scope_user(scope).active_user
    end

    def user_account_scope scope, &block
      su = scope_user_account(scope) 
      yield su if block
      su
    end

    def user_account_can?(user, *args)   
      user_account_ability(user).can?(*args)
    end

    def guest_account_can? *args
      current_guest_account.can?(*args)
    end

    def user_account_ability user_account
      @current_ability ||= ::CanTango::Ability.new(user_account)
    end

    def current_account_ability name = :user 
      user_account_ability send(:"current_#{name}_account")
    end    

    # Example: generated from types of accounts! (see below)
    # def admin_account_can?(*args)
    #   current_account_ability(:admin).can?(*args)
    # end    

    ::CanTango.user_accounts.each do |account|
      # puts "method for account: #{name}"

      class_eval %{
      def #{account}_account_can? *args
       current_account_ability(:#{account}).can?(*args)
      end
      }
    end  
  end
end

