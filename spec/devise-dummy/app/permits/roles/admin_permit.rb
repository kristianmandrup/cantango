class AdminRolePermit < CanTango::PermitEngine::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :manage, :all
  end
end

