module CanTango
  class PermitEngine < Engine
    module Executor
      class Base < Abstract
        # execute the permit
        def execute!
          valid_for?(subject) ? permit? : not_candidate_permit
        end

        protected

        def not_candidate_permit
          puts "Permit #{permit} is not valid for #{subject}" if CanTango.debug?
        end
      end
    end
  end
end
