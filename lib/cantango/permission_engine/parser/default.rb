module CanTango
  module PermissionEngine
    module Parser
      class Default < Rule
        def parse
          return ':all' if target == 'all'
          parse_class target
        end
      end
    end
  end
end


