require 'singleton'

module CanTango
  class Configuration
    class Engines
      class UserAc < Engine
        include Singleton
        include CanTango::Configuration::Modes

        def modes
          @modes ||= [:no_cache]
        end
      end
    end
  end
end



