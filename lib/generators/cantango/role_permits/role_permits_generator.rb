require 'generators/cantango/permit_generator'

module Cantango
  module Generators
    class RolePermitsGenerator < Rails::Generators::Base
      desc "Creates a Permit for each role in 'app/permits' and ensures that the permit folder is added to Rails load path."

      argument     :roles,            :type => :array,
          :desc => "Roles to create permits for"

      class_option :special_permits,  :type => :boolean,    :default => false,
          :desc => "Create special permits Syatem and Any"

      class_option :account,          :type => :string,
          :desc => "Generate permits for a specific user account"

      class_option :group,            :type => :boolean,    :default => false,  
          :desc => "Generate permits for role groups"

      source_root File.dirname(__FILE__) + '/../role_permit/templates'

      def main_flow
        create_special_permits if special_permits?
        create_permits
      end

      protected

      include Cantango::Generators::PermitGenerator

      def create_special_permits
        template_permit :any
        template_permit :system
      end

      def create_permits
        roles.each { |role| template_permit role }
      end

      def special_permits?
        options[:special_permits]
      end
    end
  end
end
