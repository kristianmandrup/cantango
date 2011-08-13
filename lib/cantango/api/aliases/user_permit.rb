module CanTango
  class UserPermit < CanTango::PermitEngine::UserPermit
    def initialize ability
      super
    end
  end
end

