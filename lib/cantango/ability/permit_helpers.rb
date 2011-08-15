module CanTango
  class Ability
    module PermitHelpers
      # by default, only execute permits for which the user
      # has a role or a role group
      # also execute any permit marked as special
      def permits
        permit_factory.build!
      end

      def permit_class_names
        @permit_class_names ||= permits.map{|p| p.class.to_s}
      end

      protected

      def permit_factory
        @permit_factory ||= CanTango::PermitEngine::Factory.new self
      end

      def permits?
        config.permits.on?
      end
    end
  end
end

