require 'singleton'

module CanTango
  class Configuration
    class Engines
      autoload_modules :Permission, :Permit, :Cache, :Store, :Engine

      include Singleton
      include Enumerable

      # engine registry is a simple hash
      def register name, engine
        raise "Must be a sublclass of CanTango::Engine" if !engine.kind_of? CanTango::Engine
        raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
        registered[name.to_sym] = engine
      end

      def registered
        @registered ||= {}
      end

      def unregister name
        @registered = {} if name == :all
        @registered.delete name
      end

      def available
        registered.keys
      end

      def available? name
        available.include? name.to_sym
      end

      def all state
        available.each {|engine| send(engine).set state }
      end

      def clear!
        available.each {|engine| send(engine).reset! }
      end

      def each
        available.each {|engine| yield send(engine) if respond_to(engine) }
      end

      def active 
        available.select {|engine| send(engine).on? if respond_to(engine) }
      end

      available.each do |engine|
        # def permission
        #   return Permission.instance
        # end
        class_eval %{
          def #{engine}
            #{engine.to_s.camelize}.instance
          end
        }
      end
    end
  end
end


