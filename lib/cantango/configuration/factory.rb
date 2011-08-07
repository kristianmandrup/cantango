module CanTango
  class Configuration
    module Factory
      def factory factory = nil, &block
        return (@factory || default_factory) if !factory && !block
        @factory = factory || yield
      end

      alias_method :factory=, :factory

      def default_factory name
        default.new name, options
      end

      attr_reader :default

      # must be a Class of type Cache (Base?)
      def default= clazz
        raise ArgumentError, "default Cache must a Class" if !is_class? clazz
        @default = clazz
      end

      def options= options = {}
        raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
        @options = options
      end

      def options
        @options ? type_options : type_options.merge options
      end

      def type_options
        {}
      end
    end
  end
end




