require 'generators/cantango/permit_generator'

module Cantango
  module Generators
    class RolePermitsGenerator < Rails::Generators::Base
      desc "Creates a Permit for each role in 'app/permits' and ensures that the permit folder is added to Rails load path."

      argument     :roles,            :type => :array,
          :desc => "Roles to create permits for"

      class_option :default_permits,  :type => :boolean,    :default => true,
          :desc => "Create default permits for guest and admin roles"

      class_option :account,          :type => :string,
          :desc => "Generate permits for a specific user account"

      class_option :group,            :type => :boolean,    :default => false,  
          :desc => "Generate permits for role groups"

      source_root File.dirname(__FILE__) + '/../role_permit/templates'

      def main_flow
        create_default_permits
        create_special_permits

        permit_logic = base_logic

        create_permits
      end

      protected

      include Cantango::Generators::PermitGenerator

      attr_accessor :permit_name, :permit_logic

      def create_default_permits
        return if default_permits?
        default_roles.each do |role|
          template_permit role
        end
      end

      def create_special_permits
        template_permit :any
        template_permit :system
      end

      def create_permits
        get_roles.each do |role|
          template_permit(role) if !skip_permit?(role)
        end
      end

      def default_permits?
        options[:default_permits]
      end

      def default_roles
        [:guest, :admin]
      end

      def skip_permit? permit
        default_permits? && default_roles.include?(permit.to_sym) 
      end


      # TODO: merge with any registered roles in application
      def get_roles
        roles.uniq.to_symbols
      end

      def template_permit role, template_name=nil
        if permit_roles.include?(role)
          meth = "#{role}_logic"
          self.permit_logic = respond_to?(meth) ? send(meth) : base_logic
        end
        self.permit_name = role
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
