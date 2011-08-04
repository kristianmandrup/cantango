require 'singleton'

module CanTango
  class Configuration
    class Engine
      class Permission
        include Singleton

        def store
          @store = Store.instance
        end

        def types
          [:roles, :role_groups, :licenses, :users]
        end

        def config_path
        end

        class Store
          def default_type
            @default_type || :memory
          end
        end
      end
    end
  end
end

