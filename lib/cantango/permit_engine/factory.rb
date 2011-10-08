module CanTango
  class PermitEngine < Engine
    class Factory
      attr_accessor :ability

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def build!
        puts "PermitEngine Factory: No permits could be built" if permits.empty? && CanTango.debug?
        permits
      end

      def permits
        @permits ||= builders.inject([]) do |permits, builder|
          puts "++ Permit Builder: #{builder_class builder}" if CanTango.debug?
          built_permits = permits_built_with(builder)
          puts "== Permits built: #{built_permits.size}" if CanTango.debug?
          permits = permits + built_permits if built_permits
        end.flatten
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

