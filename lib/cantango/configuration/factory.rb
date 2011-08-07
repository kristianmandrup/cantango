module CanTango
  class Configuration
    module Factory
      def factory factory = nil, &block
        return factory_build if !factory && !block
        @factory = factory || yield
      end

      alias_method :factory=, :factory

      def factory_build obj = nil, opts = {}
        @factory || default_factory(obj, opts = {})
      end

      def default_factory obj = nil, opts = {}
        raise "Default factory must be defined" if !default
        default_class.new obj, options.merge(opts)
      end

      attr_reader :default_class

      # must be a Class of type Cache (Base?)
      def default_class= clazz
        raise ArgumentError, "default Cache must a Class" if !is_class? clazz
        @default_class = clazz
      end

      def options= options = {}
        raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
        @options = options
      end

      def options
        @options ? type_options : type_options.merge(@options || {})
      end

      def type_options
        {}
      end
    end
  end
end




