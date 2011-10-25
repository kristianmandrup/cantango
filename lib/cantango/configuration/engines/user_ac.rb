require 'singleton'

module CanTango
  class Configuration
    class Engines
      class UserAc < Engine
        include Singleton
      end
    end
  end
end



