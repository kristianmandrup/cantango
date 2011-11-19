module CanTango
  class Ability
    module Helpers
      autoload_modules :Cache, :Masquerade, :Engine, :Permit, :PermitStore, :Role, :RoleGroup, :User, :Account
    end
  end
end
