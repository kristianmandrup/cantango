require 'singleton'

module CanTango
  class Configuration
    class Engines
      autoload_modules :Permission, :Permit, :Cache, :Store, :Engine

      include Singleton
      include Enumerable

      # engine registry is a simple hash
      def register name, engine_class
        raise "Class must implement the CanTango Engine API. You can start by sublclassing CanTango::Engine" if !engine? engine_class
        raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
        registered[name.to_sym] = engine_class
      end

      # engine factories ?
      def registered
        @registered ||= {:permits => CanTango::PermitEngine, :permissions => CanTango::PermissionEngine }
      end

      def unregister name
        @registered = {} if name == :all
        @registered.delete(name)
      end

      # defines the order of execution of engine in ability
      def execution_order *names
        @execution_order = names.select {|name| available? name }
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

      protected

      # does it implement the basic Engine API?
      def engine? engine_class
        [:execute!, :ability].all? {|meth| engine_class.instance_methods.include? meth }
      end
    end
  end
end


