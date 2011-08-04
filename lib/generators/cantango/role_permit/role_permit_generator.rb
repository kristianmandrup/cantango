require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'
# require 'logging_assist'
#
require 'generators/cantango/base'
require 'generators/cantango/license_base'
require 'generators/cantango/permit_generator'

module CanTango
  module Generators
    class RolePermitGenerator < CanTango::Generators::Base
      desc "Creates a Permit for a role in 'app/permits' with specific permissions and/or licenses"

      argument     :role,       :type => :string,   :default => '',     :desc => "Role to create permit for"

      class_option :licenses,   :type => :array,    :default => [],     :desc => "Licenses to use in Permit"

      class_option :account,          :type => :string,
          :desc => "Generate permits for a specific user account"

      class_option :group,      :type => :boolean,  :default => false,  :desc => "Generate permit for a role group"

      source_root File.dirname(__FILE__) + '/templates'

      def main_flow
        return if role.empty?
        template_permit role
      end

      protected

      include CanTango::Generators::Base
      include CanTango::Generators::LicenceBase

      def group?
        options[:group]
      end
    end
  end
end
