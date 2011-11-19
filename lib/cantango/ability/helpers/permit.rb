module CanTango
  class Ability
    module Helpers
      module Permit
        def permits?
          config.permits.on?
        end
      end
    end
  end
end

