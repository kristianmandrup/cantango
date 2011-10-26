module CanTango
  module Helpers
    module Debug
      def debug msg
        puts msg if CanTango.debug?
      end
    end
  end
end
