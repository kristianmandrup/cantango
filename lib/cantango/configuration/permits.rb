module CanTango
  class Configuration
    class Permits < PermitRegistry
      attr_reader :accounts

      def account name
        accounts[name] ||= PermitRegistry.new
      end

      def accounts
        @accounts ||= {}
      end
    end
  end
end


