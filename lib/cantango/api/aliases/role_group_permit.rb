module CanTango
  class RoleGroupPermit < CanTango::PermitEngine::RoleGroupPermit
    def initialize ability
      super
    end
  end
end
