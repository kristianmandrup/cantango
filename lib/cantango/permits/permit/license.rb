module CanTango
  module Permits
    class Permit
      module License
        def licenses *names
          names.to_strings.each do |name|
            try_license name
          end
        end

        protected

        def try_license name
          module_name = "#{name.camelize}License"
          clazz = module_name.constantize
          clazz.new(self).license_rules
        rescue NameError
          raise "License #{module_name} is not defined"
        rescue
          raise "License #{clazz} could not be enforced using #{self.inspect}"
        end
      end
    end
  end
end

