module CanTango
  module Permits
    class UserPermit < CanTango::Permit

      autoload_modules :Builder, :Finder

      def self.inherited(base_clazz)
        CanTango.config.permits.register_permit_class user_type_name(base_clazz), base_clazz, type, account_name(base_clazz)
      end

      def self.type
        :user
      end

      def self.user_type_name clazz
        clazz.name.demodulize.gsub(/(.*)(Permit)/, '\1').underscore.to_sym
      end

      # UserPermit becomes :user
      def permit_name
        self.class.user_type_name self.class
      end
      alias_method :user_type, :permit_name

      # creates the permit
      # @param [Permits::Ability] the ability
      # @param [Hash] the options
      def initialize ability
        super
      end

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
      def permit?
        super
      end

      def valid_for? subject
        debug_invalid if !(subject_user == permit_user)
        subject_user == permit_user
      end

      protected

      def debug_invalid
        puts "Not a valid permit for subject: (user class) #{subject_user} != #{permit_user} (permit user)" if CanTango.debug?
      end

      def subject_user
        subject.class.name.underscore.to_sym
      end

      # TODO
      def permit_user
        permit_name
      end
    end
  end
end

