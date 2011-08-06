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
          include Singleton
          include ClassExt

          # must be a Class of type Cache (Base?)
          def default= clazz
            raise ArgumentError, "Cache must a Class that is a kind of CanTango::Ability::Cache" if !is_class? clazz
            @default = clazz
          end

          def default
            @default ||= CanTango::Ability::Cache::SessionCache
          end

          def options= options = {}
            raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
            @options = {:type => default_type}.merge options
          end

          def options
            @options ||= {}
          end

          def default_type= type
            raise ArgumentError, "Must be a String or Symbol, was #{type}" if !type.kind_of_label?
            @default_type = type.to_sym
          end

          def default_type
            @default_type || :memory
          end
        end
      end
    end
  end
end


