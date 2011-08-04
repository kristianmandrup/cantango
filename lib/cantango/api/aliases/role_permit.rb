module CanTango
  class RolePermit < CanTango::PermitEngine::RolePermit
    def initialize ability
      super
    end
  end
end
