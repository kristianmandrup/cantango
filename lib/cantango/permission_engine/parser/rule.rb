module CanTango
  module PermissionEngine
    module Parser
      class Rule

        attr_reader :model, :target

        def initialize target
          @target = target
        end

        def parse
        end

        def parse_class target = nil
          @target = target if target
          try_class.to_s
        end

        def try_class
          target.constantize
        rescue
          raise "[permission] target #{target} does not have a class so it was skipped"
        end
      end
    end
  end
end

