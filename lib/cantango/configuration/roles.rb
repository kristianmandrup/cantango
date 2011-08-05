require 'singleton'
module CanTango
  class Configuration
    class Roles
      include Singleton

      attr_writer :default, :roles

      def roles
        @roles || default
      end

      def default
        @default ||= [:admin, :guest]
      end
    end
  end
end

