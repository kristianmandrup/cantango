module CanTango
  class Permit
    module Execution
      # executes the permit
      def execute
        return if disabled?
        debug "Execute Permit: #{self}"
        executor.execute!
        ability_sync!
      end

      # In a specific Role based Permit you can use
      #   def permit? user, options = {}
      #     return if !super(user, :in_role)
      #     ... permission logic follows
      #
      # This will call the Permit::Base#permit? instance method (the method below)
      # It will only return true if the user matches the role of the Permit class and the
      # options passed in is set to :in_role
      #
      # If these confitions are not met, it will return false and thus the outer permit 
      # will not run the permission logic to follow
      #
      # Normally super for #permit? should not be called except for this case, 
      # or if subclassing another Permit than Permit::Base
      #
      def permit?
        cached? ? cached_rules : non_cached_rules
        run_rule_methods
      end

      def run_rule_methods
        static_rules
        permit_rules
        dynamic_rules
      end

      def non_cached_rules
        include_non_cached if defined?(self.class::NonCached)
      end

      def cached_rules
        include_cached if defined?(self.class::Cached)
      end

      def include_non_cached
        self.class.send :include, self.class::NonCached
      end

      def include_cached
        self.class.send :include, self.class::Cached
      end

      # return the executor used to execute the permit
      def executor
        @executor ||= case self.class.name
        when /System/
          then CanTango::PermitEngine::Executor::System.new self
        else
          CanTango::PermitEngine::Executor::Base.new self
        end
      end

      # This method will contain the actual rules
      # can be implemented in the subclass

      def permit_rules
      end

      def static_rules
      end

      def dynamic_rules
      end
    end
  end
end
