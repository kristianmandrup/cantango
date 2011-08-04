require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'
# require 'logging_assist'

module Cancan
  module Generators
    class PermitGenerator < Rails::Generators::Base
      desc "Creates a Permit for a role in 'app/permits' with specific permissions and/or licenses"

      argument     :role,        :type => :string,      :default => '',               :desc => "Role to create permit for"

      class_option :licenses,     :type => :array,     :default => [],  :desc => "Licenses to use in Permit"

      class_option :creates,      :type => :array,     :default => [],  :desc => "Models allowed to create"
      class_option :manages,      :type => :array,     :default => [],  :desc => "Models allowed to manage"
      class_option :reads,        :type => :array,     :default => [],  :desc => "Models allowed to read"
      class_option :owns,         :type => :array,     :default => [],  :desc => "Models allowed to own"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow      
        return if role.empty?
        template_permit
      end
  
      protected

      # include RailsAssist::BasicLogger

      def creates
        options[:creates]
      end
      
      def manages
        options[:manages]
      end

      def licenses
        options[:licenses]
      end

      def reads
        options[:reads]
      end

      def owns
        options[:owns]
      end

      def template_permit        
        template "role_permit.rb", "app/permits/#{role}_permit.rb"
      end 

      def act_model name
        return ':all' if name == 'all'
        name.camelize
      end

      def permit_logic
        [:creates, :manages, :owns, :reads].map do |a|
          options[a].map do |c| 
            "can(:#{a.to_s.singularize}, #{act_model(c)})"
          end.join("\n    ")
        end.join("\n    ")
      end

      def license_logic
        return '' if licenses.empty?
        ls = licenses.map{|c| ":#{c}"}.join(", ")
        "licenses #{ls}"
      end  
    end
  end
end