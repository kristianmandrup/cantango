require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'
# require 'logging_assist'

module Cancan
  module Generators
    class LicensesGenerator < Rails::Generators::Base
      desc "Creates Licenses for use with CanCan Permits"

      argument     :licenses,           :type => :array,      :default => [],     :desc => "Licenses"
      class_option :default_licenses,   :type => :boolean,    :default => true,   :desc => "Create default exemplar licenses"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow      
        if default_licenses?
          default_licenses.each{|license| default_license license }
        end  

        licenses.each do |license|      
          template_license(license) # if !skip_license?(license)
        end    
      end
  
      protected

      # include RailsAssist::BasicLogger

      attr_accessor :license_name

      def skip_license? license
        default_licenses? && default_licenses.include?(license.to_sym) 
      end

      def default_licenses
        [:user_admin, :blogging]
      end        

      def default_licenses?
        options[:default_licenses]    
      end

      def template_license name  
        self.license_name = name        
        template "base_license.rb", "app/licenses/#{name}_license.rb"
      end
  
      def default_license name 
        template "#{name}_license.rb", "app/licenses/#{name}_license.rb"
      end
    end
  end
end