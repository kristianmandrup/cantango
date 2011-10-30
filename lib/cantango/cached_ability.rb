module CanTango
  class CachedAbility < Ability
    # Equivalent to a CanCan Ability#initialize call
    # which executes all the permission logic
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options

      # return if cached_rules?

      clear_rules!
      permit_rules

      execute_engines! if engines_on?

      # cache_rules!
    end

    def cached?
      true
    end

    def permit_rules
    end
  end
end

