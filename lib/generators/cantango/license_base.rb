module Cantango
  module Generators
    module LicenseBase
      def licenses
        options[:licenses]
      end

      def license_logic
        return ' # use any licenses here' if licenses.empty?
        ls = licenses.map{|c| ":#{c}"}.join(", ")
        "licenses #{ls}"
      end
    end
  end
end
