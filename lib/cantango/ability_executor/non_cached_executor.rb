module CanTango
  module AbilityExecutor
    class NonCached < Base
      protected

      def start_execute
        debug "executing non cached..."
      end

      def end_execute
        debug "DONE"
      end
    end
  end
end
