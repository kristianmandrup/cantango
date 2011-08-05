module CanTango
  class Configuration
    class SpecialPermits
      include Singleton

      attr_writer :default

      def default
        @default ||= [:system, :any]
      end
    end
  end
end


