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

        def config_path
          @config_path ||= File.join(::Rails.root.to_s, 'config') if rails?
          @config_path or raise "Define path to config files dir!\n"
        end

        def config_path= path
          raise "Must be a valid path to permission yaml file, was: #{path}" if !dir?(path)
          @config_path = path
        end

        class Store
          attr_writer :default_type

          def default_type
            @default_type || :memory
          end
        end
      end
    end
  end
end

