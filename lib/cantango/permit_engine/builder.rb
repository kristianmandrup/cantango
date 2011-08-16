module CanTango
  class PermitEngine < Engine
    module Builder
      autoload :Base,             'cantango/permit_engine/builder/base'
      autoload :SpecialPermits,   'cantango/permit_engine/builder/special_permits'
    end
  end
end
