module CanTango
  module Rules
    module RuleClass
      # CanCan 1.5 compatibility
      def rule_class
        return CanCan::Rule if defined? CanCan::Rule
        CanCan::CanDefinition
      end
    end
  end
end
