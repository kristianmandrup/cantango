require 'rails/generators/base'
require 'sugar-high/array'
require 'active_support/inflector'
require 'rails_artifactor'
# require 'logging_assist'

module Cantango
  module Generators
    class PermitsGenerator < Rails::Generators::Base
      desc "Creates a Permit for each role in 'app/permits' and ensures that the permit folder is added to Rails load path."

      argument     :roles,            :type => :array,      :default => [],
          :desc => "Roles to create permits for"

      # ORM to use
      class_option :orm,              :type => :string,     :default => 'active_record',
          :desc => "ORM to use"

      class_option :initializer,      :type => :boolean,    :default => true,
          :desc => "Create Permits initializer"

      class_option :default_permits,  :type => :boolean,    :default => true,
          :desc => "Create default permits for guest and admin roles"

      class_option :account,          :type => :string,
          :desc => "Generate permits for a specific user account"

      class_option :group,            :type => :boolean,    :default => false,  
          :desc => "Generate permits for role groups"

      source_root File.dirname(__FILE__) + '/../role_permit/templates'

      def main_flow
        default_roles.each do |role|
          template_permit role
        end

        template_permit :any
        template_permit :system

        permit_logic = base_logic
        get_roles.each do |role|
          template_permit(role) if !skip_permit?(role)
        end

        permits_initializer if permits_initializer?
      end

      protected

      include PermitGenerator

      extend RailsAssist::UseMacro

      use_helpers :app, :file, :special

      attr_accessor :permit_name, :permit_logic

      def default_roles
        [:guest, :admin]
      end

      def permits_initializer?
        options[:initializer]
      end

      def skip_permit? permit
        default_permits? && default_roles.include?(permit.to_sym) 
      end


      # TODO: merge with any registered roles in application
      def get_roles
        roles.uniq.to_symbols
      end

      def default_permits?
        options[:default_permits]
      end

      def orm
        options[:orm]
      end

      def permits_initializer
        create_initializer :permits do
          %Q{CanTango.configure do |config|
  config.orm = :#{orm}
end
}
        end
      end

      def template_permit role, template_name=nil
        if permit_roles.include?(role)
          meth = "#{role}_logic"
          self.permit_logic = respond_to?(meth) ? send(meth) : base_logic
        end
        self.permit_name = role
        template_permit role
      end 

      private

      def permit_roles
        [:admin, :guest, :any, :system]
      end

      def base_logic
        %{
   }
      end

      def admin_logic
        %{
          can :manage, :all
    }
      end

      def guest_logic
        %{
          can :read, :all
    }
      end
    end
  end
end
