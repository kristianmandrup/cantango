require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'

require 'generators/cantango/base'


module CanTango
  module Generators
    class LicenseGenerator < CanTango::Generators::Base
      desc "Creates a License for a Permit in 'app/licenses' with reusable permissions"

      argument     :name,         :type => :string,    :default => '',  :desc => "Name of license"

      class_option :licenses,     :type => :array,     :default => [],  :desc => "Sub licenses"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow
        return if name.empty?
        create_license
      end

      def licenses
        options[:licenses]
      end

      def create_license
        template "license.erb", "app/licenses/#{name}_license.rb"
      end

      def license_logic
        return '' if licenses.empty?
        ls = licenses.map{|c| ":#{c}"}.join(", ")
        "licenses #{ls}"
      end
    end
  end
end
