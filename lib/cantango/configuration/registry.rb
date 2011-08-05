require 'singleton'

module CanTango
  class Configuration
    class Registry
      attr_writer :default

      include Singleton

      def register *list
        @registered = list.select_labels.flat_uniq
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


