require 'singleton'

module CanTango
  class Configuration
    class Engines
      class UserAc < Engine
        def modes
          @modes ||= [:no_cache]
        end
      end
    end
  end
end



