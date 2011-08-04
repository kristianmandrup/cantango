module CanTango
  module PermitEngine
    class RolePermit < CanTango::PermitEngine::Permit
      class Finder < CanTango::PermitEngine::Finder
        def initialize account, name
          super
        end

        def type
          :role
        end

        def permit_class
          "#{name.to_s.camelize}RolePermit"
        end
      end
    end
  
  end
end
