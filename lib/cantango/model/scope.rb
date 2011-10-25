module CanTango::Model
  module Scope
    def self.included(base)
      base.send :include, CanTango::Api::User::Ability
      base.extend ClassMethods
    end

    def self.rest_actions
      [:read, :access, :write, :manage, :edit, :create, :delete]
    end

    class AllowedActions
      attr_reader :actions, :clazz

      def initialize clazz, *actions
        @clazz = clazz
        @actions = actions
      end

      def by_user user
        clazz.all.select {|obj| obj.user_ability(user).can? actions, obj }
      end
      alias_method :by, :by_user

      def by_account account
        clazz.all.select {|obj| obj.account_ability(account).can? actions, obj}
      end
    end

    module ClassMethods
      def allowed_to *actions
        CanTango::Scope::AllowActions.new self, *actions
      end

      CanTango::Model::Scope.rest_actions.each do |action|
        meth_name = action.to_s.sub(/e$/, '') << "able"
        define_method :"#{meth_name}_by" do |user|
          all.select {|obj| obj.user_ability(user).can? action.to_sym, obj }
        end
      end
    end
  end
end
