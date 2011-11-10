module CanTango
  class PermitEngine < Engine
    class SystemPermitExecutor < AbstractPermitExecutor
      # always execute system permit
      def execute!
        permit?
      end
    end
  end
end

