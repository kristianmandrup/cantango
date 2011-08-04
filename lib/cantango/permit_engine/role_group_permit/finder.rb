module CanTango
  module PermitEngine
    class RoleGroupPermit < CanTango::PermitEngine::Permit

      class Finder < CanTango::PermitEngine::Finder
        def initialize account, name
          super
        end

        def type
          :role_group
        end

        def permit_class
          "#{name.to_s.camelize}RoleGroupPermit"
        end
      end
    end
  end
end
