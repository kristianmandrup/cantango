module CanTango
  class PermissionEngine < Engine
    module Loader
      class Categories < Base
        attr_reader :file_name, :categories

        def initialize file = nil
          begin
            @file_name = file || categories_config_file
            yml_content.each do |key, value|
              parser.parse(categories, key, value)
            end

          rescue RuntimeError => e
            raise "CanTango::Categories::Loader Error: The categories for the file #{file_name} could not be loaded - cause was #{e}"
          end
        end

        def category name
          categories.category(name).subjects
        end

        def categories
          @categories ||= CanTango.config.categories
        end

        def parser
          @parser ||= CanTango::PermissionEngine::Parser::Categories.new
        end

        def load_categories name = nil
          name ||= categories_config_file
          CanTango::Categories::Loader.new name
        end

        def categories_config_file
          get_config_file 'categories'
        end

        def get_config_file name
          File.join(config_path, "#{name}.yml")
        end

        def config_path
          CanTango.config.permission_engine.config_path
        end
      end
    end
  end
end
