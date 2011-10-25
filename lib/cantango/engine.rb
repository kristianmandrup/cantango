module CanTango
  class Engine
    attr_reader :ability

    def initialize ability
      @ability = ability
    end

    def execute!
      # raise NotImplementedError
    end

    protected

    def user
      ability.user
    end

    def subject
      ability.subject
    end

    def candidate
      ability.candidate
    end
  end
end
