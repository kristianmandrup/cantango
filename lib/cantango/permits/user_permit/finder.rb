module CanTango
  module Permits
    class UserPermit < CanTango::Permit
      class Finder < CanTango::PermitEngine::Finder
        def initialize account, name
          super
        end

        def type
          :user
        end

        def permit_class
          "#{name.to_s.camelize}Permit"
        end
      end
    end
  end
end

