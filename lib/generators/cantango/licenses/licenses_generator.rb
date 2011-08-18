module Cantango
  module Generators
    class LicensesGenerator < Rails::Generators::Base
      desc "Creates Licenses for use with CanCan Permits"

      argument     :licenses,           :type => :array,      :desc => "Licenses"

      source_root File.dirname(__FILE__) + '/../license/templates'

      def main_flow
        licenses.each do |license|
          template_license(license)
        end
      end

      protected

      attr_accessor :license_name

      def template_license name
        self.license_name = name
        template "license.erb", "app/licenses/#{name}_license.rb"
      end
    end
  end
end
