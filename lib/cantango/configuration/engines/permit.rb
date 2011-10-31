module CanTango
  class Configuration
    class Engines
      class Permit < Engine
        def on?
          @state ||= :on
          @state == :on
        end

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


