module CanTango
  module Permits
    class SpecialPermit < CanTango::Permit

      autoload_modules :Builder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end
      end
      extend ClassMethods

      def initialize executor
        super
      end

      def valid_for? subject
        true
      end

      def self.hash_key
        nil
      end
    end
  end
end
