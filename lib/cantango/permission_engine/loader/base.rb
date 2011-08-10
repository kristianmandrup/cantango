module CanTango
  module PermissionEngine
    module Loader
      class Base
        attr_accessor :file_name

        def self.inherited(subclass)
          subclass.extend ClassMethods
        end

        def parser
          raise NotImplementedError
        end

        def file_name= file
          raise "Couldn't find permissions file: #{file}" if file.nil? || !File.file?(file)
          @file_name = file
        end

        def yml_content
          YAML.load_file(file_name)
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
