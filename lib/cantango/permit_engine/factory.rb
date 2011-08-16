require 'sugar-high/class_ext'

module CanTango
  class PermitEngine < Engine
    class Factory
      include ClassExt

      attr_accessor :ability, :builders

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def build!
        @builders ||= builders.inject([]) do |res, builder|
          res << create_builder(builder).build
          res
        end.flatten.compact
      end

      def create_builder builder
        clazz = builder_class(builder)
        clazz.constantize.new(ability)
      end

      def builder_class builder
        return "CanTango::PermitEngine::Builder::SpecialPermits" if builder == :special
        "CanTango::PermitEngine::#{builder.to_s.camelize}Permit::Builder"
      end

      def builders
        [:role_group, :role, :user, :account, :special]
      end

      def options
        ability.options
      end
    end
  end
end

