module CanTango
  class Ability
    def can?(action, subject, *extra_args)
      stamper("#can?") {
      match = relevant_rules_for_match(action, subject).detect do |rule|
        rule.matches_conditions?(action, subject, extra_args)
      end
      match ? match.base_behavior : false
      }
    end
  end
end
