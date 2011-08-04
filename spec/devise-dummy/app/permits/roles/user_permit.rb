class UserRolePermit < CanTango::PermitEngine::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
    can :edit, Article
    cannot :create, Article
  end
end

