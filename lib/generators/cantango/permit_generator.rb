module Cantango
  module Generators
    module PermitGenerator

      def template_permit name, account = nil
        template_account_permit name, account if account
        template permit_source, "app/permits/#{permit_target(name)}" unless account
      end

      def template_account_permit name, account
        template "account_permit.erb" , "app/permits/#{account}_permits/#{permit_target(name)}"
      end

      def load_permit_template name
        template = ERB.new File.open(template_filepath).read
        template.result(binding)
      end

      def template_filepath
        File.join source_path, permit_source
      end

      def source_path
        source_paths.first
      end

      def permit_source
        return "user_permit.erb" if user?
        return "account_permit.erb" if account?

        is_group? ? "role_group_permit.erb" : "role_permit.erb"
      end

      def permit_target name
        return "#{name}_permit.erb" if user?
        return "#{name}_account_permit.erb" if account?

        is_group? ? "#{name}_group_permit.rb" : "#{name}_permit.rb"
      end
    end
  end
end
