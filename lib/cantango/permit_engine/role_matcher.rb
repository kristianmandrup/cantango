module CanTango
  class PermitEngine < Engine
    module RoleMatcher
      def role_match? user_account
        user_account.has_role? permit_name(self.class)
      end

      def role_group_match? user, group_name = nil
        user_account.is_in_group? permit_name(self.class)
      end
    end
  end
end
