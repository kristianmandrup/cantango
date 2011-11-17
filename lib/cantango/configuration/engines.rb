require 'singleton'

module CanTango
  class Configuration
    class Engines < HashRegistry
      autoload_modules :Permission, :Permit, :PermitStore, :Cache, :Store, :Engine

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

      def default
        {:permit => CanTango::PermitEngine, :permission => CanTango::PermissionEngine, :permit_store => CanTango::PermitStoreEngine }
      end

      # defines the order of execution of engine in ability
      def execution_order= *names
        @execution_order = names.to_symbols.select {|name| available? name }
      end

      def execute_first name
        execution_order.insert(0, name)
      end

      def execute_last name
        execution_order.insert(-1, name)
      end

      def execute_before existing, name
        index = execution_order.index(existing) || 0
        execution_order.insert(index, name)
      end

      def execute_after existing, name
        index = execution_order.index(existing)
        index ? execution_order.insert(index +1, name) : execute_last(name)
      end

      def execution_order
        @execution_order ||= (self.class.default_available - [:cache])
      end

      def self.default_available
        [:cache, :permission , :permit, :permit_store]
      end

      def default_available
        self.class.default_available
      end

      def available
        (registered_names + default_available).uniq
      end

      def available? name
        available.include? name.to_sym
      end

      def all state
        available.each {|engine| send(engine).set state }
      end

      def any? state
        available.any? {|engine| send(engine).send(:"#{state}?") if respond_to?(engine) }
      end

      def clear!
        each {|engine| engine.reset! }
        @registered = nil
        @execution_order = nil
      end

      def each
        available.each {|engine| yield send(engine) if respond_to?(engine) }
      end

      def active? name
        active.include? name.to_sym
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


