class BloggersPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  def static_rules
  end
end
