module CanTango
  class Configuration
    class Permits < PermitRegistry
      include Singleton

      attr_reader :accounts
      # CanTango.config.permits.accounts[:admin].role => {}

      def accounts
        @accounts ||= Hash.new
      end

      def account_hash name
        accounts[name]
      end

      def method_missing method_name, *args
        accounts[method_name] ||= PermitRegistry.new
      end

      def register_permit_class(permit_name, permit_clazz, permit_type, account_name)
        registry = account_name ? self.send(account_name.to_sym) : self
        registry.send(permit_type)[permit_name] = permit_clazz
      end

      def permitted? actions, subjects
        executed.each do |permit|
          permit.can? actions, subjects
        end
      end

      def denied? actions, subjects
        executed.each do |permit|
          permit.cannot? actions, subjects
        end
      end

      def executed
        @executed ||= []
      end
    end
  end
end


