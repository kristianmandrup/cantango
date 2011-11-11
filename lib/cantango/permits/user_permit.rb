module CanTango
  module Permits
    class UserPermit < CanTango::Permit

      autoload_modules :Builder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end

        def permit_name clazz
          clazz.name.demodulize.gsub(/(.*)(Permit)/, '\1').underscore.to_sym
        end
      end
      extend ClassMethods

      # creates the permit
      # @param [Permits::Ability] the ability
      # @param [Hash] the options
      def initialize executor
        super
      end

      delegate :ability, :to => :executor

      attr_accessor :key, :match_value

      def valid_for? subject
        debug_invalid if !match?
        true
      end

      def match?
        return false if !subject.respond_to? key
        subject.send(key) == match_value
      end

      def self.hash_key
        nil
      end

      protected

      def debug_invalid
        debug "Not a valid permit for subject: #{key} != #{match_value}"
      end
    end
  end
end


