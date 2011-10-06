module CanTango
  class Ability
    module RoleHelpers

      include CanTango::Helpers::RoleMethods

      # return list roles the user has
      def roles
        return [] if !subject.respond_to?(roles_list_meth) || roles_of(subject).blank?
        roles_of(subject).flatten
      end

      # return list of symbols for role groups the user belongs to
      def role_groups
        return [] if !subject.respond_to?(role_groups_list_meth) || role_groups_of(subject).blank?
        role_groups_of(subject).flatten
      end

      protected

      def role_groups_of subject
        @subj_role_groups ||= subject.send(role_groups_list_meth)
      end

      def roles_of subject
        @subj_roles ||= subject.send(roles_list_meth)
      end
    end
  end
end
