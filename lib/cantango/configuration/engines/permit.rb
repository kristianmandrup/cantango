require 'singleton'

module CanTango
  class Configuration
    class Engines
      class Permit
        include Singleton

        def types
          [:roles, :role_groups, :licenses, :users]
        end

        def special_permits
          [:any, :system]
        end
      end
    end
  end
end


