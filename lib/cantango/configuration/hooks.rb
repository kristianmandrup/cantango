module CanTango
  class Configuration
    class Hooks < HashRegistry
      include Singleton
      
      def value_methods
        [:call]
      end
    end
  end
end

