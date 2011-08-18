module Cantango
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Add role strategy to a User model"

      def copy_initializer
        template "cantango.rb", "config/initializers/cantango.rb"
      end
    end
  end
end

