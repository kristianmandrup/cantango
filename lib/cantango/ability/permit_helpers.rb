module CanTango
  class Ability
    module PermitHelpers
      def permits?
        config.permits.on?
      end
    end
  end
end

