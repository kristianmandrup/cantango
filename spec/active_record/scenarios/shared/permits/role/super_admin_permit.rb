class SuperAdminPermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def static_rules
    can :manage, :all
  end  
end
