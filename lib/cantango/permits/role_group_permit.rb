module CanTango
  module Permits
    class RoleGroupPermit < CanTango::Permit

      autoload_modules :Builder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end

        def permit_name clazz
          clazz.name.demodulize.gsub(/(.*)(RoleGroupPermit)/, '\1').underscore.to_sym
        end
      end
      extend ClassMethods

      def name
        self.class.permit_name self.class
      end

      # creates the permit
      def initialize executor
        super
      end

      def execute!
        super
      end

      def valid_for? subject
        in_role_group? subject
      end

      def self.hash_key
        role_groups_list_meth
      end

      protected

      include CanTango::Helpers::RoleMethods
      extend CanTango::Helpers::RoleMethods

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
