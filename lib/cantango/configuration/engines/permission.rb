require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Permission < Engine
        include Singleton

        def store &block
          @store ||= ns::Store.instance
          @store.default = CanTango::PermissionEngine::YamlStore
          yield @store if block
          @store
        end

        def types
          [:roles, :role_groups, :licenses, :users]
        end

        attr_reader :config_path

        def config_path path = nil
          return current_config_path if !path
          raise "Must be a valid path to permission yaml file, was: #{path}" if !dir?(path)
          @config_path = path
        end
        
        alias_method :config_path=, :config_path
        
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

