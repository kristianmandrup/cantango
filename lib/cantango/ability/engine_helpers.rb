module CanTango
  class Ability
    module EngineHelpers
      def execute_engines!
        each_engine {|engine| engine.new(self).execute! if engine  }
      end

      def each_engine &block
        engines.execution_order.each do |name|
          yield engines.registered[name] if engines.active? name
        end
      end

      def engines_on?
        engines_on
      end

      def any_engines_on?
        CanTango.config.engines.any?(:on) || engines_on?
      end

      def engines
        CanTango.config.engines
      end
    end
  end
end
