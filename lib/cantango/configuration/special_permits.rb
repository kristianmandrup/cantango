module CanTango
  class Configuration
    class SpecialPermits
      include Singleton

      def default
        [:system, :any]
      end
    end
  end
end


