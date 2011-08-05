module CanTango
  class Configuration
    class RoleGroups
      include Singleton

      attr_writer :default

      def default
        @default ||= []
      end
    end
  end
end


