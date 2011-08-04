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
        store_class.new :tango_permissions, :path => config_path
      end

      def store_class
        CanTango::Configuration.store
      end

      def permission_types
        CanTango::Configuration.permission_types
      end

      def config_path
        CanTango::Configuration.config_path
      end
    end

  end
end
