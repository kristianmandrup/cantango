module CanTango
  class Configuration
    class Roles
      include Singleton

      def default
        @default ||= [:admin, :guest]
      end
    end
  end
end

