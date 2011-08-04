module CanTango
  module Generators
    module PermitGenerator
      def template_permit role, account = nil
        template_account_permit role, account if account
        template permit_source, "app/permits/#{permit_target(role)}" unless account
      end

      def template_account_permit role, account
        template "account_permit.erb" , "app/permits/#{account}_permits/#{permit_target(role)}"
      end

      def load_permit_template name
        template = ERB.new File.open(template_filepath).read
        template.result(binding)
      end

      protected

      def template_filepath
        File.join source_path, permit_source
      end

      def source_path
        source_paths.first
      end

      def permit_source
        group? ? "role_group_permit.erb" : "role_permit.erb"
      end

      def permit_target role
        group? ? "#{role}_group_permit.rb" : "#{role}_permit.rb"
      end
    end
  end
end
