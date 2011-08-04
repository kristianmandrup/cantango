require 'moneta'
require 'active_support/inflector'

module CanTango
  class Permission
    class MonetaStore < Store
      # one cache store is shared for all store instances (w different names)
      attr_reader :store

      # for a YamlStore, the name is the name of the yml file
      def initialize name, options = {}
        super
        @store = Cache.instance 
        @store.configure_with options
      end

      def self.create name, options = {}
        super
      end

      def load!
        store.load! name
      end

      def store permissions
        store.save! name, permissions.map {|p| p.to_a }
      end

      class Cache
        include Singleton

        attr_reader :options

        def configure_with options = {}
          @options ||= options
          @type ||= options[:type] || CanTango::Configuration.default_store_type
        end

        def load! name
          cache[name]
        end

        def save! name, permissions
          cache.store name, permissions
        end

        def cache
          @cache ||= begin
            moneta = Moneta::Builder.new do
              run adapter, options
            end
            moneta.clear
          end
        end

        def type
          (@type == :yaml) ? :YAML : @type
        end

        def adapter
          "Moneta::Adapters::#{type.to_s.camelize}".constantize
        end
      end
    end
  end
end
