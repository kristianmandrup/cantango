module CanTango
  class PermitEngine < Engine
    class SpecialPermitBuilder < PermitBuilder
      def build
        special_permits.map{|name| create_permit(name)}.compact
      end

      def special_permits
        [:system, :any]
      end
    end
  end
end
