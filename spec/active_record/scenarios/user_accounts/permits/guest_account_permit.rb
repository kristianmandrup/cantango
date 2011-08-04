module GuestAccountPermits
  class GuestRolePermit < CanTango::RolePermit
    def initialize(ability, options = {})
      super
    end

    def static_rules
      can :read, Post
      can :read, Article
      can :read, Comment
      cannot :read, User      
    end
  end
end
