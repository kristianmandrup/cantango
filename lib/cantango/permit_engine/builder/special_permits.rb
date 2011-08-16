module CanTango
  class PermitEngine < Engine
    module Builder
      class SpecialPermits < Base
        def build
          special_permits.map{|role| create_permit(role)}.compact
        end

        def special_permits
          [:system, :any]
        end

        def finder
          CanTango::PermitEngine::RolePermit::Finder
        end
      end
    end
  end
end
