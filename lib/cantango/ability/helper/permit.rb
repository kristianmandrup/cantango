module CanTango
  class Ability
    module Helper
      module Permit
        def permits?
          config.permits.on?
        end
      end
    end
  end
end

