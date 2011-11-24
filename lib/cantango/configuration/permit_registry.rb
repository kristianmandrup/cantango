module CanTango
  class Configuration
    class PermitRegistry
      def permits_for type        
        raise ArgumentError, "Not an available permit type: #{type}, available are: #{available_types}" if !available_types.include? type
        inst_var_name = "@#{type}"
        instance_variable_set(inst_var_name, HashRegistry.new) if !instance_variable_get(inst_var_name)
        instance_variable_get(inst_var_name)
      end

      def registered_for type, name = nil
        name ? registered_by(type)[name.to_s] : registered_by(type)
      end

      def registered_by type
        permits_for(type).registered
      end

      def all
        (available_types - [:special]).map{|type| permits_for(type)}
      end

      def show_all
        all.map(&:registered)
      end
      
      def available_types
        CanTango.config.permits.available_types
      end
    end
  end
end



