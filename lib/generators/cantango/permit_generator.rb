require 'generators/cantango/basic'

module Cantango
  module Generators
    module PermitGenerator
      attr_accessor :permit_name, :permit_logic

      include Cantango::Generators::Basic

      def template_permit name, account = nil
        @permit_name = name
        set_logic name
        account.present? ? template_account_permit(name, account) : template_simple_permit(name)
      end

      def template_simple_permit name
        template permit_source, "app/permits/#{permit_target(name)}"
      end

      def template_account_permit name, account
        template "account_permit.erb" , "app/permits/#{account}/#{permit_target(name)}"
      end

      def load_permit_template name
        template = ERB.new File.open(template_filepath).read.gsub(/\n/, "\n\s\s")
        template.result(binding)
      end

      def template_filepath
        File.join source_path, permit_source
      end

      def source_path
        source_paths.first
      end

      def permit_source
        return "user_permit.erb" if is_user?
        return "account_permit.erb" if is_account?

        is_group? ? "role_group_permit.erb" : "role_permit.erb"
      end

      def permit_target name
        name = name.to_s.underscore
        return "#{name}_permit.rb" if is_user?
        return "#{name}_account_permit.rb" if is_account?

        is_group? ? "#{name}_role_group_permit.rb" : "#{name}_role_permit.rb"
      end

      def set_logic name
        meth = "#{name}_logic"
        @permit_logic = respond_to?(meth) ? send(meth) : base_logic
      end
    end
  end
end
