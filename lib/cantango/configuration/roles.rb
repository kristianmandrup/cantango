module CanTango
  class Configuration
    class Roles
      include Singleton

      attr_writer :default

      def default
        @default ||= [:admin, :guest]
      end
    end
  end
end

