module Cantango
  module Generators
    module LicenseBase
      def licenses
        options[:licenses]
      end

      def license_logic
        return '' if licenses.empty?
        ls = licenses.map{|c| ":#{c}"}.join(", ")
        "licenses #{ls}"
      end
    end
  end
end
