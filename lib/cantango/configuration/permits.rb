module CanTango
  class Configuration
    class Permits < PermitRegistry
      include Singleton

      attr_reader :accounts

      def account name
        accounts[name] ||= PermitRegistry.new
      end

      def accounts
        @accounts ||= {}
      end

      def register_permit_class(permit_name, permit_clazz, permit_type, account_name)
        registry = account_name ? account(account_name) : self
        registry.send(permit_type)[permit_name] = permit_clazz
      end
    end
  end
end


