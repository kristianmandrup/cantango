module CanTango
  module Permits
    class AccountTypePermit < CanTango::Permit

      autoload_modules :Builder, :Finder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end

        def type
          :account
        end

        def permit_name clazz
          clazz.name.demodulize.gsub(/(.*)(AccountPermit)/, '\1').underscore.to_sym
        end
        alias_method :account_type_name, :permit_name
      end
      extend ClassMethods

      def permit_name
        self.class.permit_name self.class
      end
      alias_method :account_type, :permit_name

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
        debug_invalid if !(subject_name == account_name)
        subject_name == account_name
      end

      def self.hash_key
        account_type_name(self)
      end

      protected

      def debug_invalid
        puts "Not a valid permit for subject: (account class) #{subject_account} != #{permit_account} (permit account)" if CanTango.debug?
      end

      def subject_name
        nm = subject.class.name.sub(/.*(Account)$/, '')
        nm.underscore.to_sym
      end

      def account_name
        account_type(self.class)
      end
    end
  end
end


