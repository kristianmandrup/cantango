module CanTango
  module Helpers
    module Debug
      def debug msg
        put msg if CanTango.debug?
      end
    end
  end
end
