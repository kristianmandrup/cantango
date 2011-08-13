module CanTango
  module PermitEngine
    module Executor
      class Abstract
        attr_accessor :permit

        def initialize permit
          @permit = permit
        end

        def permit?
          permit.permit? if permit
        end

        def execute!
          raise "Must be implemented by subclass"
        end

        protected

        def options
          permit.options
        end

        def subject
          permit.subject
        end

        def user
          permit.user
        end

        def user_account
          permit.user_account
        end
      end
    end
  end
end

