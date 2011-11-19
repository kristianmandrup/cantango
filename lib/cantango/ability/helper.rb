module CanTango
  class Ability
    module Helper
      def self.modules
        [:Cache, :Masquerade, :Engine, :Permit, :PermitStore, :Role, :RoleGroup, :User, :Account]
      end
      
      autoload_modules *modules
    end
  end
end
