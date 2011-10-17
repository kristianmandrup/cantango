module CanTango
  class PermissionEngine < Engine
    module Loader
      class Base
        attr_accessor :file_name

        def self.inherited subclass
          subclass.extend ClassMethods
        end

        def parser
          raise NotImplementedError
        end

        def file_name= file
          raise "Couldn't find permissions file: #{file}. Either disable Permission engine or add this file." if file.nil? || !File.file?(file)
          @file_name = file
        end

        def yml_content
          YAML.load_file(file_name)
        rescue
          raise "Couldn't load permissions file: #{file_name}. Either disable Permission engine or add this file."
        end

        module ClassMethods
          protected

          def config_file name
            File.join(config_path, "#{name}.yml") if rails?
          end

          def config_path
            CanTango.config.permissions.config_path
          end
        end
      end
    end

  end
end
