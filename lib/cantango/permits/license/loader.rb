module CanTango::Permits
  class License
    module Loader
      def load_rules name = nil
        return if !licenses || licenses.permissions.empty?
        name ||= self.class.to_s.gsub(/License$/, "").underscore

        return if licenses.permissions[name].nil?

        licenses.permissions[name].can_eval do |permission_statement|
          instance_eval permission_statement
        end
        licenses.permissions[name].cannot_eval do |permission_statement|
          instance_eval permission_statement
        end
      end
    end
  end
end
