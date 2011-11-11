module CanTango
  module Permits
    class License
      autoload_modules :Loader, :Rules

      include Rules
      include Loader

      attr_reader :permit, :licenses

      def initialize permit
        @permit   = permit
      end

      def license_rules
        static_rules
        permit_rules
        dynamic_rules
      end

      def permit_rules
      end

      def static_rules
      end

      def dynamic_rules
      end

      protected

      def permits_loader
        CanTango::Loader::Permissions
      end
    end
  end
end
