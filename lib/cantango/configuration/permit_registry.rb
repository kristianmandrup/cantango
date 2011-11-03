module CanTango
  class Configuration
    class PermitRegistry
      def get permit
        raise ArgumentError, "Not an available permit" if !CanTango.config.permits.available_types.include? permit
        inst_var_name = "@#{permit}"
        instance_variable_set(inst_var_name, HashRegistry.new) if !instance_variable_get(inst_var_name)
        instance_variable_get(inst_var_name)
      end

      def registered_for type, name = nil
        name ? registered_by(type)[name.to_s] : registered_by(type)
      end

      def registered_by type
        get(type).registered
      end

      def all
        (CanTango.config.permits.available_types - [:special]).map{|p| send(p) if respond_to?(p)}
      end

      def show_all
        all.map(&:registered)
      end
    end
  end
end



