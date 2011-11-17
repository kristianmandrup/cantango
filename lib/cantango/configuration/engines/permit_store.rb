require 'singleton'

module CanTango
  class Configuration
    class Engines
      class PermitStore < Engine
        def modes
          @modes ||= [:no_cache]
        end

        private

        def valid_mode_names
          [:cache, :no_cache]
        end
      end
    end
  end
end



