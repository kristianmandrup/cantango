require 'sugar-high/class_ext'

module CanTango
  module PermissionEngine
    class Factory
      include ClassExt

      attr_accessor :ability

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def build!
        @evaluators ||= permission_types.inject([]) do |res, type|
          res << collector(type).build
          res
        end.flatten.compact
      end

      def collector(type)
        rules = store.send(:"#{type}_rules")
        CanTango::PermissionEngine::Collector.new(ability, rules, type)
      end

      def options
        ability.options
      end

      def store
        store_class.new :tango_permissions, store_options
      end

      def store_class
        permissions_engine.store.default_class
      end

      def store_options
        permissions_engine.store.options.merge(:path => config_path)
      end

      def permission_types
        permissions_engine.types
      end

      def config_path
        permissions_engine.config_path
      end

      private

      def permissions_engine
        CanTango.config.permissions
      end
    end
  end
end
