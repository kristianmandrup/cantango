module CanTango
  class PermitEngine < Engine
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
        debug "PermitEngine Factory: No permits could be built" if permits.empty?
        permits
      end

      # return hash of permits built, keyed by name of builder
      def permits
        puts "building..."
        @permits ||= builders.inject({}) do |permits, builder|
          debug "++ Permit Builder: #{builder_class builder}"
          built_permits = permits_built_with(builder)
          debug "== Permits built: #{built_permits.size}"
          permits[builder] = built_permits if built_permits
          permits
        end
      end

      def permits_built_with builder
        create_builder(builder).build
      end

      def create_builder builder
        clazz = builder_class(builder)
        clazz.constantize.new(ability)
      end

      def builder_class builder
        return "CanTango::PermitEngine::Builder::SpecialPermits" if builder == :special
        "CanTango::Permits::#{builder.to_s.camelize}Permit::Builder"
      end

      def builders
        CanTango.config.permits.enabled
      end

      def options
        ability.options
      end
    end
  end
end

