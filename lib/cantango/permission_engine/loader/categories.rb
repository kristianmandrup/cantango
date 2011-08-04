module CanTango
  module PermissionEngine
    module Loader 
      class Categories < Base
        attr_reader :file_name, :categories

        def initialize file = nil
          begin
            @file_name = file || categories_config_file
            yml_content.each do |key, value|
              parser.parse(categories_config, key, value) do |cat_config|
                category_config = cat_config
              end
            end

          rescue RuntimeError => e
            raise "CanTango::Categories::Loader Error: The categories for the file #{file_name} could not be loaded - cause was #{e}"
          end
        end

        def category_of_subject(category)
          categories_config.category_of_subject(category)
        end

        def categories_config
          @categories_config ||= CanTango::Configuration::Categories.new
        end

        def parser
          @parser ||= CanTango::PermissionEngine::Parser::Categories.new
        end

        def category_config
          @category_config ||= {}
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
          CanTango::Configuration.config_path
        end
      end
    end
  end
end
