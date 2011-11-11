module CanTango
  class Ability
    module NonCachedExecutor < Executor

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
