module CanTango
  class Ability
    module Executor
      include CanTango::Helpers::Debug

      delegate :session, :user, :subject, :candidate, :cached?, :to => :ability

      def execute!
        return if !valid?
        start_execute
        return if cached?

        clear_rules!
        permit_rules

        end_execute
        rules
      end

      def rules
        @rules ||= []
      end

      def clear_rules!
        @rules ||= []
      end

      def permit_rules
        raise NotImplementedError
      end

      def cached?
        false
      end

      protected

      def start_execute
        debug "executing..."
      end

      def end_execute
        debug "DONE"
      end

      def key_method_names
        []
      end
    end
  end
end
