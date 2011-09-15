module CanTango
  class Configuration
    class Debug
      include Singleton

      def set state = :on
        raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
        @state = state || :on
      end

      def on?
        @state == :on
      end

      def off?
        !on?
      end
    end
  end
end




