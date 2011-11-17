require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  class Configuration
    class Registry

      attr_writer   :default
      attr_accessor :registered

      def types= *types
        @types = types.select {|t| t.is_a? Class }
      end

      def types
        @types ||= [Symbol, String]
        @types
      end

      def clean!
        @registered = []
      end

      alias_method :clear!, :clean!

      def default!
        @registered = default
      end

      def register *list
        registered << list.select_kinds_of(*types)
        @registered.flat_uniq!
      end

      alias_method :<<, :register

      def [] index
        registered[index]
      end

      def registered
        @registered ||= default
      end

      def registered? label
        registered.map(&:to_s).include? label.to_s
      end

      def default
        @default ||= []
      end
    end
  end
end


