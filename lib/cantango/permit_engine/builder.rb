module CanTango
  class PermitEngine < Engine
    module Builder
      autoload_modules :Base, :SpecialPermits
    end
  end
end
