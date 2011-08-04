class MusiciansRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  def static_rules
    licenses :musicians
  end
end
