module CanTango
  class License < CanTango::PermitEngine::License
    def initialize permit
      super
    end
  end
end
