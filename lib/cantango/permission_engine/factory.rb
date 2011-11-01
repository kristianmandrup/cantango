module CanTango
  class PermissionEngine < Engine
    class Factory
      include CanTango::Helpers::Debug

      attr_accessor :ability

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def build!
        debug "building permissions"
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
        store_class.new :permissions, store_options
      end

      def store_class
        permission_engine.store.default_class
      end

      def store_options
        permission_engine.store.options.merge(:path => config_path)
      end

      def permission_types
        permission_engine.types
      end

      def config_path
        permission_engine.config_path
      end

      private

      def permission_engine
        CanTango.config.permission_engine
      end
    end
  end
end
