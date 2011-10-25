module CanTango
  class AbilityExecutor < CanTango::Ability
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = [candidate, options]
      @rules = cached_rules + non_cached_rules
    end

    def cached_rules
      cached_ability.send(:rules)
    end

    def non_cached_rules
      non_cached_ability.send(:rules)
    end

    def cached_ability
      CanTango::CachedAbility.new(candidate, options
    end

    def non_cached_ability
      CanTango::Ability.new(candidate, options
    end
  end
end
