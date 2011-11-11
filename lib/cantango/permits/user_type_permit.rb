module CanTango
  module Permits
    class UserTypePermit < CanTango::Permit

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

      def valid_for? subject
        debug_invalid if !(subject_user == permit_user)
        subject_user == permit_user
      end

      def self.hash_key
        user_type_name(self)
      end

      protected

      def debug_invalid
        debug "Not a valid permit for subject: (user class) #{subject_user} != #{name} (permit user)"
      end

      def subject_user
        subject.class.name.underscore.to_sym
      end
    end
  end
end

