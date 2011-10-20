module CanTango::Model
  module Scope
    def self.included(base)
      base.send :include, CanTango::Api::User::Ability
      base.extend ClassMethods
    end

    class AllowedActions
      attr_reader :actions, :clazz

      def initialize clazz, *actions
        @clazz = clazz
        @actions = actions
      end

      def by_user user
        clazz.all.select {|obj| user_ability(user).can? actions, clazz }
      end
      alias_method :by, :by_user

      def by_account account
        clazz.all.select {|obj| account_ability(account).can? actions, obj}
      end
    end

    module ClassMethods
      def allowed_to *actions
        CanTango::Scope::AllowActions.new self, *actions
      end

      [:read, :access, :write, :manage, :edit, :create, :delete].each do |meth_name|
        action = meth_name.to_s.sub(/e$/, '') << "able"
        define_method :"#{meth_name}_by" do |user|
          all.select {|obj| user_ability(user).can? action.to_sym, obj }
        end
      end
    end
  end
end
