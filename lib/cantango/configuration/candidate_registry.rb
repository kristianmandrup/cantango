require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  class Configuration
    class CandidateRegistry
      def register name, clazz
        raise "first arg must be a label" if !name.kind_of_label?
        raise "second arg must be a Class" if !clazz.kind_of? Class
        name_registry.register name.to_sym
        class_registry.register clazz
      end

      def registered
        name_registry.registered
      end

      def registered_classes
        class_registry.registered
      end

      def registered? name
        name_registry.registered? name
      end

      def registered_class? name
        class_registry.registered? name
      end

      def name_registry
        NameRegistry.instance
      end

      def class_registry
        ClassRegistry.instance
      end

      class NameRegistry < Registry
        include Singleton
      end

      class ClassRegistry < Registry
        include Singleton

        def types
          [Class]
        end
      end
    end
  end
end
