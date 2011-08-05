require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Cache
        include Singleton

        def store
          @store = Store.instance
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


