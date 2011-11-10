module CanTango
  module Permits
    class RolePermit < CanTango::Permit

      autoload_modules :Builder, :Finder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end

        def type
          :role
        end

        def permit_name clazz
          clazz.name.demodulize.gsub(/(.*)(RolePermit)/, '\1').underscore.to_sym
        end
        alias_method :role_name, :permit_name
      end
      extend ClassMethods

      def permit_name
        self.class.role_name self.class
      end
      alias_method :role, :permit_name

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
        in_role? subject
      end

      def self.hash_key
        roles_list_meth
      end

      protected

      include CanTango::Helpers::RoleMethods
      extend CanTango::Helpers::RoleMethods

      def in_role? subject
        return subject.send(has_role_meth, role) if subject.respond_to? has_role_meth
        return subject.send(roles_list_meth).include? role if subject.respond_to? roles_list_meth
        false
      end
    end
  end
end
