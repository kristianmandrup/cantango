require 'generators/cantango/base'
require 'generators/cantango/license_base'

module Cantango
  module Generators
    class LicenseGenerator < Cantango::Generators::Base 
      desc "Creates a License for a Permit in 'app/licenses' with reusable permissions"

      argument     :name,         :type => :string,    :desc => "Name of license"

      class_option :licenses,     :type => :array,     :default => [],  :desc => "Sub licenses"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow
        return if name.empty?
        create_license
      end

      protected

      def create_license
        template "license.erb", "app/permits/licenses/#{name}_license.rb"
      end

      include Cantango::Generators::LicenseBase
    end
  end
end
