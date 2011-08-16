require 'singleton'

module CanTango
  class Configuration
    class Engines
      autoload_modules :Permission, :Permit, :Cache, :Store, :Engine

      include Singleton
      include Enumerable

      # engine registry is a simple hash
      def register hash
        hash.each_pair do |name, engine_class|
          raise "Class must implement the CanTango Engine API. You can start by sublclassing CanTango::Engine" if !engine? engine_class
          raise "Name of engine must be a String or Symbol" if !name.kind_of_label?
          registered[name.to_sym] = engine_class
        end
      end

      # engine factories ?
      # :cache => Cantango::Ability::Cache
      def registered
        @registered ||= default_register
      end

      def unregister name
        @registered = {} if name == :all
        @registered.delete(name)
      end

      def default_register
        {:permit => CanTango::PermitEngine, :permission => CanTango::PermissionEngine }
      end

      # defines the order of execution of engine in ability
      def execution_order= names
        @execution_order = names.select {|name| available? name }
      end

      def execute_before existing, name
        index = execution_order.index(existing) || 0
        execution_order.insert(index, name)
      end

      def execute_after existing, name
        index = execution_order.index(existing)
        index ? execution_order.insert(index +1, name) : execution_order << name
      end

      def execution_order
        @execution_order ||= (self.class.default_available - [:cache])
      end

      def self.default_available
        [:cache, :permission , :permit]
      end

      def default_available
        self.class.default_available
      end

      def available
        (registered.keys + default_available).uniq
      end

      def available? name
        available.include? name.to_sym
      end

      def all state
        available.each {|engine| send(engine).set state }
      end

      def clear!
        each {|engine| engine.reset! }
        @registered = nil
        @execution_order = i
      end

      def each
        available.each {|engine| yield send(engine) if respond_to?(engine) }
      end

      def active
        available.select {|engine| send(engine).on? if respond_to?(engine) }
      end

      default_available.each do |engine|
        # def permission
        #   return Permission.instance
        # end
        class_eval %{
          def #{engine}
            CanTango::Configuration::Engines::#{engine.to_s.camelize}.instance
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


