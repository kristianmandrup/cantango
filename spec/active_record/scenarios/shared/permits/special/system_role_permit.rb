class SystemRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end
