module CanTango
  module PermitEngine
    class AccountPermit < CanTango::PermitEngine::Permit
      class Finder < CanTango::PermitEngine::Finder
        def initialize account, name
          super
        end

        def type
          :account
        end

        def permit_class
          "#{name.to_s.camelize}AccountPermit"
        end
      end
    end
  end
end

