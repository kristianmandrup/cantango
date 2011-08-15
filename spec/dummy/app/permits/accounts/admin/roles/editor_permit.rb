module AdminAccountPermits
  class EditorRolePermit < CanTango::RolePermit
    def initialize ability
      super
    end

    protected

    def static_rules
      can :read, [Comment, Post, Article]
      can :create, Article
    end
  end
end

