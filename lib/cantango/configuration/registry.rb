require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  class Configuration
    class Registry
      attr_writer   :default
      attr_accessor :registered

      include Singleton

      def types= *types
        @types = types.select {|t| t.is_a? Class }
      end

      def types
        @types ||= [Symbol]
        @types
      end

      def clean!
        @registered = []
      end

      def default!
        @registered = default
      end

      def << *list
        @registered << list.select_kinds_of(*types)
        @registered.flat_uniq!
      end

      def [] index
        registered[index]
      end

      def register *list
        @registered = list.select_kinds_of(*types)
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


