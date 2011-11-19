module CanTango
  class Ability
    module Helper
      module PermitStore
        def permissions?
          config.permissions.on?
        end
      end
    end
  end
end
