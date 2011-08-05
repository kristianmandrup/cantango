require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Permit
        include Singleton

        def types
          [:roles, :role_groups, :licenses, :users]
        end
      end
    end
  end
end


