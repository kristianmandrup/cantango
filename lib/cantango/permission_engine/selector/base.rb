module CanTango
  module PermissionEngine
    module Selector 
      class Base
        attr_reader :subject

        def initialize subject
          @subject = subject
        end

        def select permissions
          permissions.select{|permission| valid? permission }
        end
      end
    end
  end
end


