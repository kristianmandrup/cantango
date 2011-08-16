module CanTango
  class PermitEngine < Engine
    module Executor
      class System < Abstract
        # always execute system permit
        def execute!
          permit?
        end
      end
    end
  end
end

