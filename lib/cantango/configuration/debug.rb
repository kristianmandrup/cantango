module CanTango
  class Configuration
    # Note: This config feature is currently not used, but could potentially be of use in the future
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




