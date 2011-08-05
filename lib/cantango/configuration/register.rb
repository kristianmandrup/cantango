require 'singleton'

module CanTango
  class Configuration
    class Register
      attr_writer :default

      include Singleton

      def register= list
        @registered = list
      end

      def registered
        @registered || default
      end

      def default
        @default ||= []
      end
    end
  end
end


