require 'generators/cantango/basic'

module Cantango
  module Generators
    class Base < ::Rails::Generators::Base

      include Cantango::Generators::Basic

      CAN_ACTIONS = [:create, :update, :manage, :read, :access]

      CAN_ACTIONS.each do |action|
        class_eval %{
          class_option :#{action},      :type => :array,     :default => [],  :desc => "Models allowed to #{action}"
          class_option :not_#{action},  :type => :array,     :default => [],  :desc => "Models not allowed to #{action}"
        }
      end

      protected

      [:user, :account].each do |name|
        define_method :"#{name}?" do
          false
        end
      end

      CAN_ACTIONS.each do |action|
        class_eval %{
          def #{action}
            options[:#{action}]
          end
        }
      end

      CAN_ACTIONS.each do |action|
        class_eval %{
          def not_#{action}
            options[:not_#{action}]
          end
        }
      end

      def rules_logic
        can_logic
        cannot_logic
      end

      def can_logic
        CAN_ACTIONS.map do |action|
          send(action).map do |c|
            "can(:#{action}, #{act_model(c)})"
          end.join("\n    ")
        end.join("\n")
      end

      def cannot_logic
        CAN_ACTIONS.map do |action|
          send(action).map do |c|
            "can(:#{action}, #{act_model(c)})"
          end.join("\n    ")
        end.join("\n")
      end

      def act_model name
        return ':all' if name == 'all'
        name.camelize
      end
    end
  end
end


