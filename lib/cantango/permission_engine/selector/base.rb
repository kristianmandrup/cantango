module CanTango
  class PermissionEngine < Engine
    module Selector
      class Base
        attr_reader :subject

        def initialize subject
          @subject = subject
        end

        def select permissions
          permissions.select { |permission| relevant? permission }
        end
      end
    end
  end
end


