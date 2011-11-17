module CanTango
  class Permit
    module Macros
      def tango_permit options = {}
        name_from_class_name = CanTango::Permit.first_name self.to_s.split("::").last
        name = options[:name] || name_from_class_name

        account_from_class_name = CanTango::Permit.first_name self.to_s.split("::").first if (self.to_s.split("::").size > 1)
        account = options[:account] || account_from_class_name

        type = options[:type] || self.superclass.type

        raise "Name of permit could not be determined, try specifying a :name option" if name.nil?
        raise "Type of permit could not be determined, try specifying a :type option" if type.nil?

        CanTango.config.permits.register_permit_class name, self, type, account
        # return hash for debugging
        {:name => name, :type => type, :account => account}
      end
    end
  end
end