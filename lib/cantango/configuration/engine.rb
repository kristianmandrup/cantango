require 'singleton'

module CanTango
  class Configuration
    class Engine
      include Singleton
      include CanTango::Configuration::Modes

      def set state = :on
        raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
        @state = state || :on
      end

      def reset!
        @state = nil
      end

      def on?
        @state == :on
      end

      def off?
        !on?
      end

      protected

      def ns
        CanTango::Configuration::Engines
      end
    end
  end
end