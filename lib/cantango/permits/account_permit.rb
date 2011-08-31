module CanTango
  module Permits
    class AccountPermit < CanTango::Permit

      autoload_modules :Builder, :Finder

      def self.type
        :account_type
      end

      def self.account_type_name clazz
        self.class.name.demodulize.gsub(/(.*)(AccountPermit)/, '\1').underscore.to_sym
      end

      # fx for Admin account class, becomes simply AdminAccountPermit
      def account_type
        self.class.role_group_name self.clazz
      end

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
    end

  end
end


