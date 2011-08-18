module Cantango
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Add role strategy to a User model"

      source_root File.expand_path("../templates", __FILE__)

      class_option :categories,       :type => :boolean,     :default => true,  :desc => "Create categories"
      class_option :permissions,      :type => :boolean,     :default => true,  :desc => "Create yaml permissions store"

      def copy_initializer
        template "cantango.rb", "config/initializers/cantango.rb"
      end

      def copy_categories
        return unless categories?
        template "categories.yml", "config/categories.yml"
      end

      def copy_permissions
        return unless permissions?
        template "cantango_permissions.yml", "config/cantango_permissions.yml"
      end

      protected

      def permissions?
        options[:permissions]
      end

      def categories?
        options[:categories]
      end
    end
  end
end

