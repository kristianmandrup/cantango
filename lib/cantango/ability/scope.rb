module CanTango
  class Ability
    class Scope
      attr_accessor :ability

      def initialize ability
        @ability = ability
      end

      def can? *args
        ability.can? *args
      end

      def cannot? *args
        ability.cannot? *args
      end
    end
  end
end
 
