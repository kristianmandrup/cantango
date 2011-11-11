module CanTango
  module Permits
    class RolePermit < CanTango::Permit

      autoload_modules :Builder

      module ClassMethods
        def inherited(base_clazz)
          CanTango.config.permits.register_permit_class base_clazz
        end
      end
      extend ClassMethods

      # creates the permit
      # @param [Permits::Ability] the ability
      # @param [Hash] the options
      def initialize ability
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
