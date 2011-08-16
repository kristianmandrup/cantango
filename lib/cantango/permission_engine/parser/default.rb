module CanTango
  class PermissionEngine < Engine
    module Parser
      class Default < Rule
        def parse
          return default_all if target == 'all'
          parse_class target
          "#{method}(:#{action}, #{target})"
        end

        def default_all
          "#{method}(:#{action}, :all)"
        end
      end
    end
  end
end


