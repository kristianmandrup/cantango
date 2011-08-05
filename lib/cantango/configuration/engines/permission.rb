require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Permission
        include Singleton

        def store
          @store = Store.instance
        end

        def types
          [:roles, :role_groups, :licenses, :users]
        end

        def config_path path = nil
          return current_config_path if !path
          raise "Must be a valid path to permission yaml file, was: #{path}" if !dir?(path)
          @config_path = path
        end

        class Store
          attr_writer :default_type, :default

          def default
            CanTango::PermissionEngine::YamlStore
          end

          def default_type
            @default_type || :memory
          end
        end

        private

        def current_config_path
          @config_path ||= File.join(::Rails.root.to_s, 'config') if rails?
          @config_path or raise "Define path to config files dir!\n"
        end

        def rails?
          defined?(::Rails) && ::Rails.respond_to?(:root)
        end

        def dir? dir
          return false if !dir
          File.directory?(dir)
        end
      end
    end
  end
end

