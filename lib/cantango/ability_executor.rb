module CanTango
  class AbilityExecutor < CanTango::Ability
    attr_reader :rules

    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = [candidate, options]
      @rules = cached_rules + non_cached_rules
    end

    def cached_rules
      cache_mode? ? cached_ability.send(:rules) : []
    end

    def non_cached_rules
      no_cache_mode? ? non_cached_ability.send(:rules) : []
    end

    def cached_ability
      CanTango::CachedAbility.new candidate, options
    end

    def non_cached_ability
      CanTango::Ability.new candidate, options
    end

    protected

    def no_cache_mode?
      modes.include?(:no_cache)
    end

    def cache_mode?
      modes.include?(:cache)
    end

    def modes
      CanTango.config.ability.modes
    end
  end
end
