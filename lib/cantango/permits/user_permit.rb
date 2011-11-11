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

      # In a specific Role based Permit you can use 
      #   def permit? user, options = {}
      #     ... permission logic follows
      #
      # This will call the Permit::Base#permit? instance method (the method below)
      # It will only return true if the user matches the role of the Permit class and the
      #
      # If these confitions are not met, it will return false and thus the outer permit 
      # will not run the permission logic to follow
      #
      # Normally super for #permit? should not be called except for this case, 
      # or if subclassing another Permit than Permit::Base
      #
      def execute!
        super
      end

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


