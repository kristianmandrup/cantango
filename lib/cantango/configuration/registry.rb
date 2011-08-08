require 'singleton'

module CanTango
  class Configuration
    class Registry
      attr_writer :default
      attr_accessor :registered

      include Singleton

      def register *list
        puts "#{registered} --- #{list.select_labels}"
        @registered |= list.select_labels
      end

      def registered
        @registered ||= default
      end

      def default
        @default ||= []
      end
    end
  end
end


