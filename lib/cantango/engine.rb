module CanTango
  class Engine
    attr_reader :ability

    def initialize ability
      @ability = ability
    end

    def execute!
      # raise NotImplementedError      
    end
  end
end
