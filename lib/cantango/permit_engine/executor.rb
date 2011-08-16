module CanTango
  class PermitEngine < Engine
    module Executor
      autoload_modules :Abstract, :Base, :System
    end
  end
end
