module CanTango
  module PermissionEngine
    class Collector
      attr_reader :ability, :permissions, :type

      def initialize ability, permissions, type
        @ability = ability
        @permissions = permissions
        @type = type
      end

      def build
        relevant_rules.inject([]){|evaluators, (name, rules)| 
          # puts "injecting evaluator of #{name} rules"
          evaluators << CanTango::PermissionEngine::Evaluator.new(ability, rules) 
        }
      end

      def relevant_rules
        # puts "relevant_rules for #{type}"
        selector.select permissions
      end

      def selector
        CanTango::PermissionEngine::Selector.create type, self
      end

      def role_groups_list
        ability.role_groups
      end

      def roles_list
        ability.roles
      end

      def user
        ability.user
      end

      def user_key_field
        ability.user_key_field
      end
    end
  end
end
