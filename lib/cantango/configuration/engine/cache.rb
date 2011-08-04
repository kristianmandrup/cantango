require 'singleton'

module CanTango
  class Configuration
    class Cache
      include Singleton

      def store
        @store = Store.instance
      end

      class Store
        def default_type
          @default_type || :memory
        end
      end
    end
  end
end


