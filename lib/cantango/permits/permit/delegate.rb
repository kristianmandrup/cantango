module CanTango
  module Permits
    class Permit
      module Delegate
        def cached?
          ability.cached?
        end

        def options
          ability.options
        end

        def subject
          ability.subject
        end

        def user
          ability.user
        end

        def user_account
          ability.user_account
        end

        def ability_rules
          ability.send(:rules)
        end
      end
    end
  end
end


