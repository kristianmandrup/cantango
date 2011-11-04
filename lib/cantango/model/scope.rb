module CanTango::Model
  module Scope
    def self.included(base)
      base.send :include, CanTango::Api::User::Ability
      base.extend CanTango::Api::User::Ability
      base.extend ClassMethods
    end

    def self.rest_actions
      [:read, :access, :write, :manage, :edit, :create, :delete]
    end

    class AllowedActions
      include CanTango::Api::User::Ability


      attr_reader :actions, :mode, :clazz

      def initialize clazz, mode, *actions
        @clazz = clazz
        @mode = mode
        @actions = actions.flatten
      end

      def by_user user
        check user_ability(user)
      end
      alias_method :by, :by_user

      def by_account account
        check account_ability(account)
      end

      protected

      def check ability
        clazz.all.select do |obj|
         actions.all? do |action|
            ability.send mode_action, action.to_sym, obj
          end
        end
      end

      def mode_action
        "#{mode}?"
      end
    end

    module ClassMethods
      def allowed_to *actions
        CanTango::Model::Scope::AllowedActions.new self, :can, *actions
      end

      def not_allowed_to *actions
        CanTango::Model::Scope::AllowedActions.new self, :cannot, *actions
      end

      CanTango::Model::Scope.rest_actions.each do |action|
        meth_name = action.to_s.sub(/e$/, '') << "able"
        define_method :"#{meth_name}_by" do |user|
          all.select {|obj| obj.user_ability(user).can? action.to_sym, obj }
        end

        define_method :"not_#{meth_name}_by" do |user|
          all.select {|obj| obj.user_ability(user).cannot? action.to_sym, obj }
        end
      end
    end
  end
end
