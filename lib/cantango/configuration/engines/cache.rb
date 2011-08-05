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

          def options= options = {}
            raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
            @options = {:type => default_cache_type}.merge options
          end

          def options
            @options ||= {}
          end

          def default
            CanTango::Ability::Cache::MonetaCache
          end

          def default_type
            @default_type || :memory
          end
        end
      end
    end
  end
end


