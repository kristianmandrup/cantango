module CanTango
  module Permits
    class RoleGroupPermit < CanTango::Permit

      autoload_modules :Builder, :Finder

      def self.inherited(base_clazz)
        CanTango.config.permits.register_permit_class role_group_name(base_clazz), base_clazz, type, account_name(base_clazz)
      end

      def self.type
        :role_group
      end

      def self.role_group_name clazz
        clazz.name.demodulize.gsub(/(.*)(RoleGroupPermit)/, '\1').underscore.to_sym
      end

      def permit_name
        self.class.role_group_name self.class
      end

      alias_method :role_group, :permit_name

      # creates the permit
      def initialize ability
        super
      end

      # In a specific Role based Permit you can use 
      #   def permit? user, options = {}
      #     return if !super(user, :in_group)
      #     ... permission logic follows
      #
      # This will call the Permit::Base#permit? instance method (the method below)
      # It will only return true if the user matches the role of the Permit class and the
      # options passed in is set to :in_role
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
        in_role_group? subject
      end

      protected

      include CanTango::Helpers::RoleMethods

      def in_role_group? subject
        has_role_group?(subject) || role_groups_of(subject).include?(role) 
      end

      def has_role_group? subject
        subject.send(has_role_group_meth, role) if subject.respond_to?(has_role_group_meth) 
      end

      def role_groups_of subject
        subject.respond_to?(role_groups_list_meth) ? subject.send(role_groups_list_meth) : []
      end
    end
  end
end
